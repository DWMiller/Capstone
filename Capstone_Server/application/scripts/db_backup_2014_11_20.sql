-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 20, 2014 at 09:42 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

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
  `player1_losses` int(10) NOT NULL,
  `player2_losses` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `battle_id` (`id`),
  KEY `player1_id` (`player1_id`),
  KEY `player2_id` (`player2_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `departure_id`, `size`, `destination_id`, `departure_time`, `arrival_time`) VALUES
(1, 4, 3, NULL, 96, NULL, NULL, NULL),
(2, 5, 9, NULL, 96, NULL, NULL, NULL),
(4, 3, 23, NULL, 2, NULL, NULL, NULL),
(5, 2, 29, NULL, 96, NULL, NULL, NULL),
(10, 3, 26, NULL, 92, NULL, NULL, NULL),
(24, 1, 35, NULL, 4, NULL, NULL, NULL),
(35, 1, 6, NULL, 80, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `game_settings`
--

CREATE TABLE IF NOT EXISTS `game_settings` (
  `time_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `name`, `category`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(1, NULL, 1, 500, 500, 'gezminla', 'star', 'blueStar', 0, 14, 0, 0, 0),
(2, NULL, 1, 317, 277, 'gezminla Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(3, 4, 1, 165, 870, 'netvet', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(4, NULL, 1, 261, 486, 'net ro ', 'planet', 'molten', 5, 6, 0, 0, 0),
(5, NULL, 2, 500, 500, 'teltha', 'star', 'blueStar', 0, 30, 0, 0, 0),
(6, NULL, 2, 884, 128, 'teltha Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(7, 1, 2, 203, 738, 'so ro di ', 'planet', 'molten', 5, 6, 0, 0, 0),
(8, 1, 2, 798, 836, 'gezra', 'planet', 'desert', 2, 14, 0, 0, 0),
(9, 5, 2, 649, 810, 'dire netnas ', 'planet', 'volcanic', 6, 6, 1, 1, 1),
(10, 1, 2, 26, 159, 'ste qua min cebi sodi ', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(11, 1, 2, 304, 817, 'cebirequa ', 'planet', 'ice', 1, 4, 0, 0, 0),
(12, NULL, 3, 500, 500, 'mintelminre ra', 'star', 'blueStar', 0, 20, 0, 0, 0),
(13, NULL, 3, 626, 800, 'mintelminre ra Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(14, NULL, 3, 95, 154, 'cebitheso', 'planet', 'ice', 1, 9, 0, 0, 0),
(15, NULL, 4, 500, 500, 'rala ', 'star', 'blueStar', 0, 20, 0, 0, 0),
(16, NULL, 4, 281, 461, 'rala  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(17, NULL, 4, 176, 11, 'sla ditcebi', 'planet', 'ice', 1, 4, 0, 0, 0),
(18, NULL, 4, 53, 406, 'ditra', 'planet', 'volcanic', 6, 4, 0, 0, 0),
(19, NULL, 5, 500, 500, 'la lanet', 'star', 'redDwarf', 0, 14, 0, 0, 0),
(20, NULL, 5, 728, 165, 'la lanet Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(21, NULL, 5, 350, 944, 'sla lex', 'planet', 'ice', 1, 4, 0, 0, 0),
(22, NULL, 5, 639, 851, 'min sori sela ', 'planet', 'ice', 1, 4, 0, 0, 0),
(23, NULL, 6, 500, 500, 'tha cebilathe ', 'star', 'redDwarf', 0, 14, 0, 0, 0),
(24, NULL, 6, 168, 191, 'tha cebilathe  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(25, NULL, 6, 637, 60, 'thethanetgez net', 'planet', 'molten', 5, 6, 0, 0, 0),
(26, 3, 6, 174, 633, 'la di', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(27, NULL, 7, 500, 500, 'tel berso lextha ', 'star', 'whiteDwarf', 0, 9, 0, 0, 0),
(28, NULL, 7, 917, 761, 'tel berso lextha  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(29, 2, 7, 72, 92, 'net ro mincebi ', 'planet', 'volcanic', 6, 4, 1, 1, 1),
(30, NULL, 8, 500, 500, 'tel la ', 'star', 'whiteDwarf', 0, 6, 0, 0, 0),
(31, NULL, 8, 981, 872, 'tel la  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(32, NULL, 8, 701, 216, 'sothenet qua ', 'planet', 'molten', 5, 4, 0, 0, 0),
(33, NULL, 8, 290, 16, 'la nas', 'planet', 'molten', 5, 4, 0, 0, 0),
(34, NULL, 9, 500, 500, 'minsomin ', 'star', 'whiteDwarf', 0, 4, 0, 0, 0),
(35, NULL, 9, 991, 944, 'minsomin  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0);

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
(1, 1, 178, 388, 'gezminla', 14, 'blueStar'),
(2, 1, 881, 698, 'teltha', 30, 'blueStar'),
(3, 1, 444, 745, 'mintelminre ra', 20, 'blueStar'),
(4, 1, 85, 788, 'rala ', 20, 'blueStar'),
(5, 1, 624, 462, 'la lanet', 14, 'redDwarf'),
(6, 1, 722, 742, 'tha cebilathe ', 14, 'redDwarf'),
(7, 1, 202, 228, 'tel berso lextha ', 9, 'whiteDwarf'),
(8, 1, 178, 634, 'tel la ', 6, 'whiteDwarf'),
(9, 1, 918, 565, 'minsomin ', 4, 'whiteDwarf');

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
  `resources` int(10) NOT NULL,
  `tech_weapons` tinyint(3) NOT NULL DEFAULT '0',
  `tech_propulsion` tinyint(3) NOT NULL DEFAULT '0',
  `tech_armour` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(1, 3, 1, 'admin', '4lqJghfb5sFBZlnhQ6uvgBV6R5jrkb.RibDVOU7C', '2fe2c5df10044969c2131a8c1bcb95f7b1c391f5a19ce3e3aeedd035c8d9fe5836ec8d48f3fa946d5090c22275d66935', 194, 0, 0, 0),
(2, 3, 0, 'test', 'BF./28f5K2pmepG30jyzyZoiFKQiwQMyoHYUEVfU', 'f8c792e3892eeb94b32fa945a36870ee3a51fe35ad1b1845a1dbe8bf19968b558ad1d86e31e0e2c693ef9e6746997474', 194, 0, 0, 0),
(3, 3, 0, 'test1', 'e22asfFxJazv6NsZcG60gBYjmzjGEHsN6c.3LawI', 'fa1516b78d7654ec25ec158fca472e3359d60e9fe5f4db260041967d5145eb8b3568c2ee45d348a2f6e00f45fd64751e', 194, 0, 0, 0),
(4, 3, 0, 'test2', 'sAyb2XfTlc9zOsGNHDzal7q8BL7dz6ZekADclrJb', '4baabbd1239c5c8da949e521b984303be225b5d4ffc5da7476f8d2ff0826ac8f7bd11a351f48a5e8fd85752db5f1a0b1', 194, 0, 0, 0),
(5, 3, 0, 'test3', 'AC6S0YWb/dvUKgDYIP2F8fnar4x86spkSNxnRCoT', 'bad9613bb10ed12701308850071a3f632cbdd5764fd14abbd14b493e123d577ff9f0b76d02a4d60073aed8f42469c526', 194, 0, 0, 0);

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
(2, 'c3TozmkLMkHXGFzPE5Nw4/4GcdQ2re0HV00NAaer', 1),
(3, 'MIXCYX.yek91BHSs8tzi558Ty3C.mnR2tKb5.ebZ', 1),
(4, 'rnvZ366ZxcJCTObNg.WhjvJscRB08/ZDjLyItaZG', 1),
(5, 'gVDRPotLsWhemrEBo7Lf0O9iGpouim5Fp6R9mmIY', 1);

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
