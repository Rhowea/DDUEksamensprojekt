-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql58.unoeuro.com
-- Generation Time: Apr 24, 2024 at 12:33 PM
-- Server version: 8.0.36-28
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kroog_dk_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`kroog_dk`@`%` PROCEDURE `rankUpdate` ()   BEGIN

DECLARE done BOOL DEFAULT FALSE;
DECLARE found BOOL DEFAULT FALSE;
DECLARE curId int;
DECLARE curRank int;
DECLARE iterator int DEFAULT 1;
DECLARE cur CURSOR FOR SELECT id, `rank` FROM `players_secure` ORDER BY score DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN cur;

theLoop: LOOP
    FETCH cur INTO curId, curRank;
    IF done THEN LEAVE theLoop; END IF;
    IF NOT curRank THEN
    	SET found = TRUE;
    END IF;
    IF found THEN
    	UPDATE `players_secure` 
    	SET `rank` = iterator
    	WHERE `id` = curId;
    END IF;
    SET iterator = iterator + 1;
END LOOP theLoop;

CLOSE cur;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nonces`
--

CREATE TABLE `nonces` (
  `ip_address` varchar(32) NOT NULL,
  `nonce` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_secure`
--

CREATE TABLE `players_secure` (
  `id` int NOT NULL,
  `player_name` tinytext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `score` int NOT NULL,
  `grade` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'G',
  `rank` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `players_secure`
--

INSERT INTO `players_secure` (`id`, `player_name`, `score`, `grade`, `rank`) VALUES
(1, 'AdamTrunc', 22144, 'D', 3),
(2, 'AdamTrunc', 16038, 'S', 12),
(3, 'AdamBeef', 18292, 'D', 8),
(4, 'AdamPlant2', 18208, 'S', 9),
(5, 'AdamPlant3', 25330, 'S', 1),
(6, 'AdamBeef2', 19006, 'D', 6),
(7, 'AdamMid', 20017, 'B', 5),
(8, 'AdamCursor', 11218, 'D', 16),
(9, 'AdamBad', 159, 'A', 26),
(10, 'Demo1', 18306, 'D', 7),
(11, 'Simon', 892, 'D', 25),
(12, 'Marinus', 6368, 'C', 21),
(13, 'Adamksi', 8117, 'C', 19),
(14, 'Demo2', 20403, 'B', 4),
(15, 'Cecilie', 15756, 'C', 14),
(16, 'Demo3', 15946, 'D', 13),
(17, 'WowS', 22450, 'S', 2),
(18, 'S', 16452, 'C', 11),
(19, 'SS', 5882, 'D', 22),
(20, 'Get', 5690, 'D', 23),
(21, 'Get2', 5190, 'D', 24),
(22, 'EXE', 6388, 'D', 20),
(23, 'Rapport', 11194, 'D', 17),
(24, 'Bob', 18098, 'D', 10),
(25, 'WebWorks', 9050, 'D', 18),
(26, 'NetworkTes', 15700, 'D', 15);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nonces`
--
ALTER TABLE `nonces`
  ADD PRIMARY KEY (`ip_address`);

--
-- Indexes for table `players_secure`
--
ALTER TABLE `players_secure`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `players_secure`
--
ALTER TABLE `players_secure`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
