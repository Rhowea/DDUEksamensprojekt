<?php
	include "db_connection_test.php";
	
	if($_SERVER["REQUEST_METHOD"] == "OPTIONS"){
		http_response_code(200);
		die;
	}
	
	#Returns information and data to Godot
	function print_response($dictionary = [], $error = "none"){
		$string = "{\"error\" : \"$error\",
					\"command\" : \"$_REQUEST[command]\",
					\"response\" : ". json_encode($dictionary) ."}";
					
		#Print out json to Godot
		echo $string;
	}
	
	function verify_nonce($pdo, $secret = "1234567890"){
		
		if(!isset($_SERVER["HTTP_CNONCE"])){
			print_response([], "invalide_nonce");
			return false;
		}
		
		$template = "SELECT nonce FROM `nonces` WHERE ip_address = :ip";
		$sth = $pdo -> prepare($template);
		$sth -> execute(["ip" => $_SERVER["REMOTE_ADDR"]]);
		$data = $sth -> fetchAll(PDO::FETCH_ASSOC);
		
		if(!isset($data)){
			print_response([], "server_missing_nonce");
			return false;
		}

		if(sizeof($data) <= 0){
			print_response([], "server_missing_nonce_data_returned_0_size");
			return false;
		}
		
		$sth = $pdo -> prepare("DELETE FROM `nonces` WHERE ip_address = :ip");
		$sth -> execute(["ip" => $_SERVER["REMOTE_ADDR"]]);
		
		$server_nonce = $data[0]["nonce"];
		
		if (hash("sha256", $server_nonce . $_SERVER["HTTP_CNONCE"] . file_get_contents("php://input") . $secret) != $_SERVER["HTTP_HASH"]){
				print_response([], "invalid_nonce_or_hash");
				return false;
		}
		
		return true;			
	}
	
	
	#Handle error: 
	#Missing command
	if (!isset($_REQUEST["command"]) or $_REQUEST["command"] === null){
		print_response([], "missing_command");
		//echo "{\"error\":\"missing_command\",\"response\":{}}";
		die;
	}
	
	#Missing data
	if (!isset($_REQUEST["data"]) or $_REQUEST["data"] === null){
		print_response([], "missing_data");
		die;
	}
	
	#Convert Godot json to dictionary
	$dict_from_json = json_decode($_REQUEST["data"], true);
	
	#Is dictionary valid
	if ($dict_from_json === null){
		print_response([], "invalid_json");
		die;
	}
	
	switch ($_REQUEST["command"]){
		
		#Get nonce
		case "get_nonce":
			$bytes = random_bytes(32);
			$nonce = hash("sha256", $bytes);
			$template = "INSERT INTO `nonces` (ip_address, nonce) VALUES (:ip, :nonce) ON DUPLICATE KEY
			UPDATE nonce = :nonce_update";
			$pdo = OpenConnPDO();
			
			$sth = $pdo -> prepare($template);
			$sth -> execute(["ip" => $_SERVER["REMOTE_ADDR"], "nonce" => $nonce, "nonce_update" => $nonce]);
			
			print_response(["nonce" => $nonce]);
			
			die;
		break;
		
		#Adding score
		case "add_score":
			
			#Handle error for add score
			if (!isset($dict_from_json["score"])) {
				print_response([], "missing_score");
				die;
			}
							
			if (!isset($dict_from_json["username"])) {
				print_response([], "missing_username");
				die;
			}
			
			if (!isset($dict_from_json["grade"])) {
				print_response([], "missing_grade");
				die;
			}
			# Username max length 40, -> should be handled in Godot
			$username = $dict_from_json["username"];
			if (strlen($username) > 40)
				$username = substrt($username, 40);
			$score = $dict_from_json["score"];
			$grade = $dict_from_json["grade"];

			$template = "INSERT INTO `players_secure` (player_name, score, grade) VALUES (:username, :score, :grade) ON DUPLICATE
			KEY UPDATE score = GREATEST(score, VALUES(score))";
			
			$pdo = OpenConnPDO();
			if(!verify_nonce($pdo))
				die;
			
			$sth = $pdo -> prepare($template);
			$sth -> bindValue("username", $username);
			$sth -> bindValue("score", $score, PDO::PARAM_INT);
			$sth -> bindValue("grade", $grade, PDO::PARAM_STR);
			$sth -> execute(); 
			CloseConnPDO($pdo);
			$template = "CALL `rankUpdate`";
			$pdo = OpenConnPDO();
			
			$sth = $pdo -> prepare($template);
			$sth -> execute();
			
			#Response to Godot, all is fine
			print_response(array("size" => 0));
			die;
		break;
		
		case "get_scores":
			$score_number_of = 10;
			$score_offset = 0;
			
			#Check for new values
			if (isset($dict_from_json["score_offset"]))
				$score_offset = max(0, (int)$dict_from_json["score_offset"]);
							
			if (isset($dict_from_json["score_number"]))
				$score_number_of = max(1, (int)$dict_from_json["score_number"]);
			
			$template = "SELECT * FROM `players_secure` ORDER BY score DESC LIMIT :number OFFSET :offset";
			
			#Make a connection to the DB
			$pdo = OpenConnPDO();
			//verify_nonce($pdo);
			if(!verify_nonce($pdo))
				die;
			
			$sth = $pdo -> prepare($template);			
			$sth -> bindValue("number", $score_number_of, PDO::PARAM_INT);
			$sth -> bindValue("offset", $score_offset, PDO::PARAM_INT);
			$sth -> execute();

			$players = $sth -> fetchAll(PDO::FETCH_ASSOC);
			
			$players["size"] = sizeof($players);
			
			CloseConnPDO($pdo);
			print_response($players);
			die;
		break;
		
		
		case "get_player":
		
			#Handle missing user id
			if (!isset($dict_from_json["player_name"])){
				print_response([], "missing_user_id");
				die;
			}
			
			$player_name = $dict_from_json["player_name"];

			$template = "SELECT * FROM `players_secure` WHERE `player_name` = :player_name;";
		
			#Make a connection to the DB
			$pdo = OpenConnPDO();
			//verify_nonce($pdo);
			if(!verify_nonce($pdo)) die;
			
			$sth = $pdo -> prepare($template);			
			$sth -> bindValue("player_name", $player_name, PDO::PARAM_STR);
			$sth -> execute();

			$players = $sth -> fetchAll(PDO::FETCH_ASSOC);
			
			$players["size"] = sizeof($players);				

			CloseConnPDO($pdo);

			if (sizeof($players) == 0) print_response([], "no_player_with_matching_name");
			
			print_response($players);
			die;		
		break;
		
		#Handle none excisting request
		default:
			print_response([], "invalid_command");
			die;
		break;
	}

?>