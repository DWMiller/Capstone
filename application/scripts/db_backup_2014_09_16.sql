-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 16, 2014 at 08:50 AM
-- Server version: 5.6.13
-- PHP Version: 5.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `capstone`
--
CREATE DATABASE IF NOT EXISTS `capstone` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `capstone`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_expired_sessions`()
    DETERMINISTIC
    COMMENT 'Erases expired sessions'
BEGIN
	DELETE FROM `active_sessions` WHERE `expires` < NOW();
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `active_sessions`
--

CREATE TABLE IF NOT EXISTS `active_sessions` (
  `user_id` int(10) NOT NULL,
  `session` varchar(40) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `active_sessions`
--

INSERT INTO `active_sessions` (`user_id`, `session`, `expires`) VALUES
(18, '.x8KyoFW6qJUbesl8RtkH5OBRa1v4pa6yEPBoOQc', '2014-09-16 01:11:08'),
(18, 'cnmm/c49WEhJAosRrzIX8noev01j5XGI6b/7YnoD', '2014-09-16 01:21:20'),
(18, '/6CNLHmtTvvy3p0iPoe3HKUpNx83G8SGs3EyqIiT', '2014-09-16 01:22:23'),
(18, 'CcKXv0kO8RzFgRDweI8LKs0mcvjrR8P0eBr5ua32', '2014-09-16 01:23:04'),
(18, 'gXoOckuicPSTAqlIL0.hEmLkxhKj1dGMTBdfc0cP', '2014-09-16 01:37:42'),
(18, 'Ny2rLbLPjTXpa.WkJTG9WOj7HsNoGq8WI1LNwn4v', '2014-09-16 01:39:35'),
(17, 'vLkYyjsDkhAoXDENQF0RQNrGWVISOGai327P2JKo', '2014-09-16 01:44:40'),
(18, 'mJXE73sGUkpU3/XYaegsHcAYnvXNGlRqR0OZSYWE', '2014-09-16 01:44:54'),
(18, 'bVCcKbD/5ZeZBwvXHDmFZySFCIoox/6FvZnAcC90', '2014-09-16 01:49:08'),
(18, 'o6b2PYF3X/jPU/W7wEP/0nQAvzpYG1MWQdJ.Sgze', '2014-09-16 01:50:45'),
(18, 'zqSONUoYbwGqpfNjJfr9rymafvmdBbu.8vaGnjwU', '2014-09-16 01:52:17'),
(18, 'rsJVAjUuH.A3Wo8geIRPOJOytbHFp0Gpo2/TDapu', '2014-09-16 01:54:51'),
(18, '2qokUvfm0BCK96PW5ywSLG/jUAZzuAR6vqI6ji46', '2014-09-16 01:55:12'),
(17, 'luV2v8hCLHieD/DYOq7780XOxlB7vZPP2EkCNrLo', '2014-09-16 01:57:18'),
(17, 'VAurC41DsqQKJZeG.oqpZscn4LbiRXYY4iAvxiaT', '2014-09-16 01:58:24'),
(17, 'hYTdjrznMHSrN1T7EfYf.RxCxyBl2eS5IFSjAuAs', '2014-09-16 02:00:33'),
(18, 'DBD7.I1ogSUtQGiiKMWnsWNYpHxTkb4XtrPJS4VR', '2014-09-16 02:00:37'),
(17, 'R2zQMGk9WtZApkKR8c2wicdHa8VqT599W.vAL78R', '2014-09-16 02:00:42'),
(17, 'lM8diEF3C/uAbxbvmQxMdsNX6LlXgZqxs4UCi3jh', '2014-09-16 02:07:47');

-- --------------------------------------------------------

--
-- Table structure for table `battles`
--

CREATE TABLE IF NOT EXISTS `battles` (
  `id` int(10) NOT NULL,
  `status` tinyint(3) NOT NULL,
  `time_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_ended` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `battle_rounds`
--

CREATE TABLE IF NOT EXISTS `battle_rounds` (
  `battle_id` int(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `player1_losses` int(10) NOT NULL,
  `player2_losses` int(10) NOT NULL,
  KEY `battle_id` (`battle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `user_id` int(10) NOT NULL,
  `location_id` int(10) NOT NULL,
  `type` tinyint(3) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `user_id` (`user_id`,`location_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fleets`
--

CREATE TABLE IF NOT EXISTS `fleets` (
  `id` int(10) NOT NULL,
  `owner_id` int(10) NOT NULL,
  `location_id` int(10) NOT NULL,
  `size` int(10) NOT NULL,
  `destination_id` int(10) NOT NULL,
  `arrival_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `battle_id` int(10) NOT NULL,
  KEY `owner_id` (`owner_id`,`location_id`,`destination_id`,`battle_id`),
  KEY `location_id` (`location_id`),
  KEY `destination_id` (`destination_id`),
  KEY `battle_id` (`battle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `game_settings`
--

CREATE TABLE IF NOT EXISTS `game_settings` (
  `time_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resource_pool` int(10) NOT NULL,
  `max_players` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) DEFAULT NULL,
  `system_id` smallint(5) NOT NULL,
  `position_x` smallint(4) NOT NULL,
  `position_y` smallint(4) NOT NULL,
  `type` varchar(20) NOT NULL,
  `resources` int(10) NOT NULL,
  `size` tinyint(3) NOT NULL,
  `mines` tinyint(3) NOT NULL DEFAULT '0',
  `shipyards` tinyint(3) NOT NULL DEFAULT '0',
  `labs` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_id` (`system_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7940 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(7911, NULL, 1657, 384, 664, 'ice', 1, 4, 0, 0, 0),
(7912, NULL, 1657, 179, 813, 'volcanic', 5, 6, 0, 0, 0),
(7913, NULL, 1657, 980, 734, 'ice', 1, 4, 0, 0, 0),
(7914, NULL, 1657, 815, 18, 'molten', 6, 9, 0, 0, 0),
(7915, NULL, 1657, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(7916, NULL, 1658, 449, 523, 'terran', 3, 9, 0, 0, 0),
(7917, NULL, 1658, 429, 337, 'molten', 6, 9, 0, 0, 0),
(7918, NULL, 1658, 498, 196, 'terran', 3, 4, 0, 0, 0),
(7919, NULL, 1658, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(7920, NULL, 1659, 789, 310, 'terran', 3, 4, 0, 0, 0),
(7921, NULL, 1659, 278, 119, 'terran', 3, 6, 0, 0, 0),
(7922, NULL, 1659, 306, 766, 'terran', 3, 4, 0, 0, 0),
(7923, NULL, 1659, 500, 500, 'blueStar', 0, 14, 0, 0, 0),
(7924, NULL, 1660, 521, 91, 'desert', 2, 6, 0, 0, 0),
(7925, NULL, 1660, 106, 217, 'ice', 1, 9, 0, 0, 0),
(7926, NULL, 1660, 910, 720, 'ice', 1, 4, 0, 0, 0),
(7927, NULL, 1660, 481, 421, 'desert', 2, 4, 0, 0, 0),
(7928, NULL, 1660, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(7929, NULL, 1661, 217, 542, 'terran', 3, 4, 0, 0, 0),
(7930, NULL, 1661, 915, 489, 'ice', 1, 4, 0, 0, 0),
(7931, NULL, 1661, 500, 500, 'redDwarf', 0, 6, 0, 0, 0),
(7932, NULL, 1662, 537, 547, 'ice', 1, 6, 0, 0, 0),
(7933, NULL, 1662, 766, 754, 'ice', 1, 4, 0, 0, 0),
(7934, NULL, 1662, 621, 893, 'ice', 1, 4, 0, 0, 0),
(7935, NULL, 1662, 500, 500, 'blueStar', 0, 14, 0, 0, 0),
(7936, NULL, 1663, 519, 206, 'ice', 1, 6, 0, 0, 0),
(7937, NULL, 1663, 500, 500, 'whiteDwarf', 0, 6, 0, 0, 0),
(7938, NULL, 1664, 299, 246, 'ice', 1, 4, 0, 0, 0),
(7939, NULL, 1664, 500, 500, 'redDwarf', 0, 4, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `systems`
--

CREATE TABLE IF NOT EXISTS `systems` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `sector_id` smallint(4) NOT NULL,
  `position_x` smallint(4) NOT NULL,
  `position_y` smallint(4) NOT NULL,
  `size` smallint(6) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1665 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `size`, `type`) VALUES
(1657, 1, 382, 285, 20, 'blueStar'),
(1658, 1, 425, 10, 20, 'yellowStar'),
(1659, 1, 483, 455, 14, 'blueStar'),
(1660, 1, 390, 572, 20, 'yellowStar'),
(1661, 1, 487, 512, 6, 'redDwarf'),
(1662, 1, 406, 63, 14, 'blueStar'),
(1663, 1, 245, 94, 6, 'whiteDwarf'),
(1664, 1, 131, 517, 4, 'redDwarf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `salt` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `resources` int(10) NOT NULL,
  `tech_weapons` tinyint(3) NOT NULL DEFAULT '0',
  `tech_propulsion` tinyint(3) NOT NULL DEFAULT '0',
  `tech_armour` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `username`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(17, 2, 0, 'GV.W3IQU1v8t3dh4Le4CJ0HVEoPnxYwR23liG6HI', 'root', 'IidIfQKi1GjEZx4GoD7nsJqGKHePWM1zvSpXHzL8', 'c3654fba631e654cf618a15dcb5cedcbdbbe2058b7042e784023daf0ea709f687a93056e2423b17cf44b3f0082150602', 0, 0, 0, 0),
(18, 1, 1, '2q3o3CHLwvtDcLDe8xsM7g846NZ.zvfRC8c7PHHt', 'admin', 'NphdFxVrXT8ueLpZgNfUemtghjlj/iBJoKm8v3ec', 'e344575382996d08c8ad8bc6e809cd6e93216226249ce1ca70b038eac0341669d8f1985d5eeafbf57aee7236330ad208', 0, 0, 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `active_sessions`
--
ALTER TABLE `active_sessions`
  ADD CONSTRAINT `active_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `battle_rounds`
--
ALTER TABLE `battle_rounds`
  ADD CONSTRAINT `battle_rounds_ibfk_1` FOREIGN KEY (`battle_id`) REFERENCES `battles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `fleets`
--
ALTER TABLE `fleets`
  ADD CONSTRAINT `fleets_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fleets_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fleets_ibfk_3` FOREIGN KEY (`destination_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fleets_ibfk_4` FOREIGN KEY (`battle_id`) REFERENCES `battles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`system_id`) REFERENCES `systems` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
