-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 17, 2014 at 06:00 AM
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` int(10) unsigned NOT NULL,
  `session` varchar(40) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `active_sessions`
--

INSERT INTO `active_sessions` (`user_id`, `id`, `ip`, `session`, `expires`) VALUES
(1, 19, 0, 'OJ8SyoGelLEIa7EOg7bLgqtka1MZ133N2AyIuMqe', '2014-11-16 12:01:44');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `departure_id`, `size`, `destination_id`, `departure_time`, `arrival_time`) VALUES
(1, 3, 13311, NULL, 32, NULL, NULL, NULL),
(2, 2, 13315, NULL, 32, NULL, NULL, NULL),
(3, 1, 13336, NULL, 32, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13340 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `name`, `category`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(13309, NULL, 2769, 500, 500, 'quacebi', 'star', 'whiteDwarf', 0, 9, 0, 0, 0),
(13310, NULL, 2769, 457, 423, 'quacebi Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13311, 3, 2769, 986, 27, 'ditnas ', 'planet', 'molten', 6, 6, 1, 1, 1),
(13312, NULL, 2769, 420, 3, 'ste qua min cebi sodi ', 'planet', 'terran', 3, 4, 0, 0, 0),
(13313, NULL, 2770, 500, 500, 'solathe vet', 'star', 'redDwarf', 0, 9, 0, 0, 0),
(13314, NULL, 2770, 374, 564, 'solathe vet Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13315, 2, 2770, 80, 19, 'cebirequa ', 'planet', 'molten', 6, 6, 1, 1, 1),
(13316, NULL, 2771, 500, 500, 'diro ', 'star', 'redDwarf', 0, 9, 0, 0, 0),
(13317, NULL, 2771, 8, 560, 'diro  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13318, NULL, 2771, 773, 174, 'cebitheso', 'planet', 'ice', 1, 4, 0, 0, 0),
(13319, NULL, 2771, 360, 721, 'sla ditcebi', 'planet', 'desert', 2, 4, 0, 0, 0),
(13320, NULL, 2772, 500, 500, 'tha di', 'star', 'blueStar', 0, 14, 0, 0, 0),
(13321, NULL, 2772, 263, 342, 'tha di Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13322, NULL, 2772, 276, 766, 'ditra', 'planet', 'terran', 3, 6, 0, 0, 0),
(13323, NULL, 2772, 534, 290, 'sla lex', 'planet', 'terran', 3, 4, 0, 0, 0),
(13324, NULL, 2772, 195, 651, 'min sori sela ', 'planet', 'molten', 6, 4, 0, 0, 0),
(13325, NULL, 2773, 500, 500, 'ra la ', 'star', 'redDwarf', 0, 14, 0, 0, 0),
(13326, NULL, 2773, 569, 592, 'ra la  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13327, NULL, 2773, 353, 26, 'thethanetgez net', 'planet', 'desert', 2, 4, 0, 0, 0),
(13328, NULL, 2773, 489, 156, 'la di', 'planet', 'ice', 1, 4, 0, 0, 0),
(13329, NULL, 2774, 500, 500, 'laso', 'star', 'redDwarf', 0, 14, 0, 0, 0),
(13330, NULL, 2774, 881, 879, 'laso Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13331, NULL, 2774, 192, 131, 'net ro mincebi ', 'planet', 'volcanic', 5, 6, 0, 0, 0),
(13332, NULL, 2774, 598, 3, 'sothenet qua ', 'planet', 'ice', 1, 6, 0, 0, 0),
(13333, NULL, 2774, 799, 380, 'la nas', 'planet', 'desert', 2, 4, 0, 0, 0),
(13334, NULL, 2775, 500, 500, 'minvetra ro ste', 'star', 'whiteDwarf', 0, 6, 0, 0, 0),
(13335, NULL, 2775, 58, 830, 'minvetra ro ste Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13336, 1, 2775, 588, 652, 'telminmin', 'planet', 'molten', 6, 4, 1, 1, 1),
(13337, NULL, 2776, 500, 500, 'nas di lex ragezre ', 'star', 'whiteDwarf', 0, 4, 0, 0, 0),
(13338, NULL, 2776, 787, 348, 'nas di lex ragezre  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(13339, NULL, 2776, 76, 522, 'berraritel ', 'planet', 'molten', 6, 4, 0, 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2777 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `name`, `size`, `type`) VALUES
(2769, 1, 679, 501, 'quacebi', 9, 'whiteDwarf'),
(2770, 1, 170, 602, 'solathe vet', 9, 'redDwarf'),
(2771, 1, 146, 111, 'diro ', 9, 'redDwarf'),
(2772, 1, 407, 357, 'tha di', 14, 'blueStar'),
(2773, 1, 913, 904, 'ra la ', 14, 'redDwarf'),
(2774, 1, 310, 448, 'laso', 14, 'redDwarf'),
(2775, 1, 14, 898, 'minvetra ro ste', 6, 'whiteDwarf'),
(2776, 1, 158, 745, 'nas di lex ragezre ', 4, 'whiteDwarf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(1, 3, 1, 'admin', '4lqJghfb5sFBZlnhQ6uvgBV6R5jrkb.RibDVOU7C', '2fe2c5df10044969c2131a8c1bcb95f7b1c391f5a19ce3e3aeedd035c8d9fe5836ec8d48f3fa946d5090c22275d66935', 98, 0, 0, 0),
(2, 3, 0, 'test', 'BF./28f5K2pmepG30jyzyZoiFKQiwQMyoHYUEVfU', 'f8c792e3892eeb94b32fa945a36870ee3a51fe35ad1b1845a1dbe8bf19968b558ad1d86e31e0e2c693ef9e6746997474', 98, 0, 0, 0),
(3, 3, 0, 'test1', 'e22asfFxJazv6NsZcG60gBYjmzjGEHsN6c.3LawI', 'fa1516b78d7654ec25ec158fca472e3359d60e9fe5f4db260041967d5145eb8b3568c2ee45d348a2f6e00f45fd64751e', 98, 0, 0, 0);

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
(3, 'MIXCYX.yek91BHSs8tzi558Ty3C.mnR2tKb5.ebZ', 1);

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
