<?php
	header("Access-Control-Allow-Origin: *");
 	header("Access-Control-Max-Age: 60");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, FETCH");
	header("Access-Control-Allow-Headers: Authorization, Content-Type, Accept, Origin, Cache-Control, Cnonce, Hash");

	function OpenConnPDO() {
		$db_host = "mysql58.unoeuro.com";
		$db_name = "kroog_dk_db";
		$db_username = "kroog_dk";
		$db_password = "RG3Dxcpz2kd6E4tFwH9r";

		#Set up logindata for PDO
		$dsn = "mysql:dbname=$db_name;host=$db_host;charset=utf8mb4;port=3306";			
		
		#Attempt connection and catch error
		try{
			$pdo = new PDO($dsn, $db_username, $db_password); 	
		}
		catch (\PDOException $e){
			print_response("no_return", [], "db_login_error");
			die;
		}
		
		return $pdo;
	}
	
	function CloseConnPDO($pdo)
	{
		//$pdo -> close();
	}
?>
	