-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 11, 2014 at 09:28 PM
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `ip` int(10) unsigned NOT NULL,
  `session` varchar(40) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `active_sessions`
--

INSERT INTO `active_sessions` (`id`, `user_id`, `ip`, `session`, `expires`) VALUES
(1, 1, 0, 'ddg9Pj6b/6N5BBzPSsG2jHwt6gFP.N5.2NRwuxz5', '2014-12-11 22:01:06');

-- --------------------------------------------------------

--
-- Table structure for table `battle_logs`
--

CREATE TABLE IF NOT EXISTS `battle_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location_id` int(10) NOT NULL,
  `player1_id` int(10) NOT NULL,
  `player2_id` int(10) NOT NULL,
  `player1_roll` int(3) unsigned NOT NULL,
  `player2_roll` int(3) unsigned NOT NULL,
  `player1_bonus_roll` int(3) unsigned NOT NULL,
  `player2_bonus_roll` int(3) unsigned NOT NULL,
  `player1_bonus_roll2` int(3) unsigned NOT NULL,
  `player2_bonus_roll2` int(3) unsigned NOT NULL,
  `player1_losses` int(10) NOT NULL,
  `player2_losses` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `battle_id` (`id`),
  KEY `player1_id` (`player1_id`),
  KEY `player2_id` (`player2_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `battle_logs`
--

INSERT INTO `battle_logs` (`id`, `timestamp`, `location_id`, `player1_id`, `player2_id`, `player1_roll`, `player2_roll`, `player1_bonus_roll`, `player2_bonus_roll`, `player1_bonus_roll2`, `player2_bonus_roll2`, `player1_losses`, `player2_losses`) VALUES
(1, '2014-12-10 19:31:22', 3, 9, 1, 0, 0, 0, 0, 0, 0, 10, 12),
(2, '2014-12-10 19:31:25', 3, 9, 1, 0, 0, 0, 0, 0, 0, 9, 12);

-- --------------------------------------------------------

--
-- Table structure for table `fleets`
--

CREATE TABLE IF NOT EXISTS `fleets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) NOT NULL,
  `location_id` int(10) DEFAULT NULL,
  `departure_id` int(10) unsigned DEFAULT NULL,
  `size` int(10) NOT NULL DEFAULT '0',
  `destination_id` int(10) DEFAULT NULL,
  `departure_time` int(11) unsigned DEFAULT NULL,
  `arrival_time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`,`location_id`,`destination_id`),
  KEY `location_id` (`location_id`),
  KEY `destination_id` (`destination_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `departure_id`, `size`, `destination_id`, `departure_time`, `arrival_time`) VALUES
(1, 9, 3, NULL, 173, NULL, NULL, NULL),
(3, 5, 9, NULL, 192, NULL, NULL, NULL),
(4, 6, 11, NULL, 192, NULL, NULL, NULL),
(5, 7, 13, NULL, 192, NULL, NULL, NULL),
(6, 8, 21, NULL, 192, NULL, NULL, NULL),
(7, 10, 40, NULL, 192, NULL, NULL, NULL),
(8, 1, 1, NULL, 72, NULL, NULL, NULL),
(9, 1, 5, NULL, 212, NULL, NULL, NULL),
(11, 1, 4, NULL, 100, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `game_details`
--

CREATE TABLE IF NOT EXISTS `game_details` (
  `time_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `players` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `game_details`
--

INSERT INTO `game_details` (`time_started`, `players`) VALUES
('2014-12-10 17:58:50', 7);

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
  `name` varchar(30) NOT NULL,
  `category` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `resources` int(10) NOT NULL,
  `size` tinyint(3) NOT NULL,
  `mines` tinyint(3) NOT NULL DEFAULT '0',
  `shipyards` tinyint(3) NOT NULL DEFAULT '0',
  `labs` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_id` (`system_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=46 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `name`, `category`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(1, NULL, 1, 500, 500, 'somin ', 'star', 'yellowStar', 0, 20, 0, 0, 0),
(2, NULL, 1, 401, 496, 'somin  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(3, 9, 1, 862, 788, 'vetcebi gez ', 'planet', 'volcanic', 6, 6, 1, 1, 1),
(4, 1, 1, 730, 30, 'quarose ', 'planet', 'volcanic', 6, 4, 1, 3, 1),
(5, 1, 1, 190, 485, 'vetthe', 'planet', 'volcanic', 6, 4, 1, 3, 1),
(6, NULL, 2, 500, 500, 'nasdit', 'star', 'yellowStar', 0, 20, 0, 0, 0),
(7, NULL, 2, 265, 811, 'nasdit Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(8, NULL, 2, 955, 676, 'vetnasla', 'planet', 'molten', 5, 4, 0, 0, 0),
(9, 5, 2, 107, 463, 'rolex la', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(10, NULL, 2, 731, 725, 'seso ', 'planet', 'molten', 5, 4, 0, 0, 0),
(11, 6, 2, 683, 592, 'sedit', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(12, NULL, 2, 349, 441, 'nas slanet ', 'planet', 'ice', 1, 4, 0, 0, 0),
(13, 7, 2, 670, 835, 'thetel', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(14, NULL, 3, 500, 500, 'netsla sla', 'star', 'blueGiant', 0, 46, 0, 0, 0),
(15, NULL, 3, 388, 274, 'netsla sla Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(16, NULL, 3, 58, 523, 'di resosemin', 'planet', 'gasGiant', 0, 20, 0, 0, 0),
(17, NULL, 3, 274, 550, 'the ramin ', 'planet', 'terran', 3, 6, 0, 0, 0),
(18, NULL, 3, 368, 856, 'rinetnet ', 'planet', 'ice', 1, 6, 0, 0, 0),
(19, NULL, 3, 155, 287, 'raquagez ', 'planet', 'terran', 3, 9, 0, 0, 0),
(20, NULL, 3, 642, 2, 'di rageznas rise', 'planet', 'ice', 1, 6, 0, 0, 0),
(21, 8, 3, 911, 931, 'rethe', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(22, NULL, 4, 500, 500, 'berlex ', 'star', 'redGiant', 0, 46, 0, 0, 0),
(23, NULL, 4, 437, 595, 'berlex  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(24, NULL, 4, 261, 2, 'ri dira gez ', 'planet', 'terran', 3, 14, 0, 0, 0),
(25, NULL, 4, 934, 941, 'netdit rogez', 'planet', 'terran', 3, 14, 0, 0, 0),
(26, NULL, 4, 674, 921, 'dit redit', 'planet', 'molten', 5, 6, 0, 0, 0),
(27, NULL, 4, 722, 294, 'nasro ', 'planet', 'desert', 2, 9, 0, 0, 0),
(28, NULL, 4, 47, 517, 'di cebicebire', 'planet', 'ice', 1, 6, 0, 0, 0),
(29, NULL, 5, 500, 500, 'raste ste', 'star', 'blueStar', 0, 14, 0, 0, 0),
(30, NULL, 5, 411, 619, 'raste ste Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(31, NULL, 6, 500, 500, 'vetbermingez la ', 'star', 'blueStar', 0, 20, 0, 0, 0),
(32, NULL, 6, 234, 496, 'vetbermingez la  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(33, NULL, 6, 41, 264, 'lexvet ', 'planet', 'ice', 1, 4, 0, 0, 0),
(34, NULL, 7, 500, 500, 'cebi se', 'star', 'whiteDwarf', 0, 6, 0, 0, 0),
(35, NULL, 7, 540, 488, 'cebi se Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(36, NULL, 7, 907, 103, 'la cebitel', 'planet', 'ice', 1, 4, 0, 0, 0),
(37, NULL, 8, 500, 500, 'ste tel', 'star', 'blueStar', 0, 30, 0, 0, 0),
(38, NULL, 8, 657, 76, 'ste tel Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(39, NULL, 8, 137, 700, 'lex gez', 'planet', 'terran', 3, 9, 0, 0, 0),
(40, 10, 8, 517, 230, 'tha ritha', 'planet', 'volcanic', 6, 9, 1, 1, 1),
(41, NULL, 8, 112, 280, 'ber ra min ', 'planet', 'molten', 5, 6, 0, 0, 0),
(42, NULL, 8, 373, 717, 'ditro', 'planet', 'molten', 5, 9, 0, 0, 0),
(43, NULL, 9, 500, 500, 'tha tha nas vet ', 'star', 'whiteDwarf', 0, 4, 0, 0, 0),
(44, NULL, 9, 898, 571, 'tha tha nas vet  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(45, NULL, 9, 684, 744, 'lexber the ', 'planet', 'molten', 5, 4, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `systems`
--

CREATE TABLE IF NOT EXISTS `systems` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `sector_id` smallint(4) NOT NULL,
  `position_x` smallint(4) NOT NULL,
  `position_y` smallint(4) NOT NULL,
  `name` varchar(30) NOT NULL,
  `size` smallint(6) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `name`, `size`, `type`) VALUES
(1, 1, 670, 189, 'somin ', 20, 'yellowStar'),
(2, 1, 677, 995, 'nasdit', 20, 'yellowStar'),
(3, 1, 331, 902, 'netsla sla', 46, 'blueGiant'),
(4, 1, 493, 255, 'berlex ', 46, 'redGiant'),
(5, 1, 904, 646, 'raste ste', 14, 'blueStar'),
(6, 1, 354, 115, 'vetbermingez la ', 20, 'blueStar'),
(7, 1, 909, 504, 'cebi se', 6, 'whiteDwarf'),
(8, 1, 124, 105, 'ste tel', 30, 'blueStar'),
(9, 1, 599, 722, 'tha tha nas vet ', 4, 'whiteDwarf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(40) NOT NULL,
  `salt` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `resources` int(10) NOT NULL DEFAULT '0',
  `knowledge` int(10) NOT NULL DEFAULT '0',
  `tech_weapons` tinyint(3) NOT NULL DEFAULT '0',
  `tech_propulsion` tinyint(3) NOT NULL DEFAULT '0',
  `tech_armour` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `email`, `salt`, `password`, `resources`, `knowledge`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(1, 3, 1, 'admin', '4lqJghfb5sFBZlnhQ6uvgBV6R5jrkb.RibDVOU7C', '2fe2c5df10044969c2131a8c1bcb95f7b1c391f5a19ce3e3aeedd035c8d9fe5836ec8d48f3fa946d5090c22275d66935', 87, 48, 0, 1, 0),
(5, 3, 0, 'test@test.com', 'wGhbEFSZ1hH7IXYU8s62h3f9yZHZew7sn2jU1ifY', '73a49d1d25b0bc05f53a7ca07ceb64b460fc001f0824366244a57e54184d2be1f3bcdbc2a52a2bc3171844613b7e4466', 338, 48, 0, 0, 0),
(6, 3, 0, 'test1@test.com', 'jWyitw6/rKtVVDLaGdWxyl0VqKmK3EXxSTRpmNoI', '9574133cd91bf83e4511570a8bf7ea0eef76c875227d50a5d1b8482e00bbb2a913735bbc5b6784e6ef62b00222c4dc09', 338, 48, 0, 0, 0),
(7, 3, 0, 'test2@test.com', 'u7WYgPdyjw1w5jc9S2TOt5fhz8rzElZW4S9hS.Bc', 'e48ea66ea808374656214f054069ab334afd5e6e885c9237a731f8360d8ba02bed32bfc9ff11c70eb5ae79e02ed7ac5d', 338, 48, 0, 0, 0),
(8, 3, 0, 'test3@test.com', 'vkoCeHerXMzAk2MjtlSfP0NgVBsGq4gq/VSwIzGz', 'f326896e959b0b9c779e69c93b6ecb862881f65d332a7d41483f37e2890c697f30ae4ee69dfd3c850ff62aa3abeada97', 338, 48, 0, 0, 0),
(9, 3, 0, 'test4@test.com', 'tOu324K8q1WDAyfFDiV17MKlJjXP0lX0ZcwpB911', 'abb9e50ba88a36eac1c7297f752a51fb83ea45446c4ea290b60b5d232d68e193a4dd2d7cad5f486e776ba75ff677a927', 338, 48, 0, 0, 0),
(10, 3, 0, 'test5@test.com', 'X8OweFTABqzToKPnC76RNCr7aeEy5bCpZh3ktDD1', '9ae7a0300092d3d5608d9e59c025afb5d65ba077cb47de2d99dd87c53dc7d9165276279de1d6b7f6d39e9c7da9a76d8a', 338, 48, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE IF NOT EXISTS `user_settings` (
  `user_id` int(10) NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `show_animations` tinyint(4) NOT NULL DEFAULT '1',
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`user_id`, `username`, `show_animations`) VALUES
(1, 'gWlYrxl52F9eg3ZYPIWYwNLP8DIBBZIZ4sdXugZk', 1),
(5, 'xLGu9p54L3aiAsUW4Keq/V5PmyxQIF.QpdkGCB/b', 1),
(6, 'yvBpVbI0et9Xo7BBbzS0NMGH2zvEQUprFIpSV6rh', 1),
(7, 'oRdjNhXKeuVn9r43JUtlx7UbNUnP.TVfD1GlPie1', 1),
(8, 'emju9rYgZHvTNa096f7i.S1b17fBo4F.co.Va9nV', 1),
(9, 'kEV3pgXnl4G63SLmwLLjPvGFUK7PgWuLCFBATmeB', 1),
(10, 'tDjlQtci3GiAsPGLs8DqY8rHl/iERKsmvLHWFl5H', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `active_sessions`
--
ALTER TABLE `active_sessions`
  ADD CONSTRAINT `active_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `battle_logs`
--
ALTER TABLE `battle_logs`
  ADD CONSTRAINT `battle_logs_ibfk_2` FOREIGN KEY (`player1_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `battle_logs_ibfk_3` FOREIGN KEY (`player2_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `battle_logs_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `fleets`
--
ALTER TABLE `fleets`
  ADD CONSTRAINT `fleets_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fleets_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fleets_ibfk_3` FOREIGN KEY (`destination_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`system_id`) REFERENCES `systems` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `user_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
