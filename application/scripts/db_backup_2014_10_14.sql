-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 15, 2014 at 02:26 AM
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
(18, 'TFbpmXmL0bATyQDrp2ROF5uL3apSmSFRZWRumk8g', '2014-10-15 02:51:39');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10246 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(10198, 24, 2125, 481, 113, 'terran', 3, 9, 1, 1, 1),
(10199, NULL, 2125, 696, 520, 'desert', 2, 9, 0, 0, 0),
(10200, NULL, 2125, 13, 104, 'volcanic', 5, 9, 0, 0, 0),
(10201, NULL, 2125, 354, 58, 'gasGiant', 0, 20, 0, 0, 0),
(10202, NULL, 2125, 253, 809, 'molten', 6, 6, 0, 0, 0),
(10203, 24, 2125, 500, 500, 'redGiant', 0, 46, 1, 1, 1),
(10204, NULL, 2126, 906, 407, 'ice', 1, 9, 0, 0, 0),
(10205, NULL, 2126, 521, 958, 'desert', 2, 6, 0, 0, 0),
(10206, NULL, 2126, 684, 142, 'volcanic', 5, 9, 0, 0, 0),
(10207, NULL, 2126, 913, 113, 'molten', 6, 6, 0, 0, 0),
(10208, NULL, 2126, 905, 702, 'molten', 6, 4, 0, 0, 0),
(10209, NULL, 2126, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(10210, NULL, 2127, 546, 169, 'gasGiant', 0, 20, 0, 0, 0),
(10211, 24, 2127, 839, 822, 'terran', 3, 9, 1, 1, 1),
(10212, 24, 2127, 470, 978, 'terran', 3, 14, 1, 1, 1),
(10213, NULL, 2127, 532, 929, 'molten', 6, 9, 0, 0, 0),
(10214, NULL, 2127, 369, 969, 'molten', 6, 4, 0, 0, 0),
(10215, NULL, 2127, 500, 500, 'redGiant', 0, 46, 0, 0, 0),
(10216, NULL, 2128, 821, 784, 'desert', 2, 4, 0, 0, 0),
(10217, NULL, 2128, 640, 828, 'volcanic', 5, 4, 0, 0, 0),
(10218, NULL, 2128, 411, 648, 'desert', 2, 6, 0, 0, 0),
(10219, NULL, 2128, 699, 132, 'molten', 6, 4, 0, 0, 0),
(10220, NULL, 2128, 530, 371, 'desert', 2, 4, 0, 0, 0),
(10221, NULL, 2128, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(10222, NULL, 2129, 509, 533, 'molten', 6, 4, 0, 0, 0),
(10223, NULL, 2129, 78, 698, 'ice', 1, 6, 0, 0, 0),
(10224, 18, 2129, 852, 659, 'desert', 2, 4, 1, 1, 1),
(10225, NULL, 2129, 619, 354, 'ice', 1, 4, 0, 0, 0),
(10226, NULL, 2129, 327, 706, 'volcanic', 5, 4, 0, 0, 0),
(10227, NULL, 2129, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(10228, NULL, 2130, 353, 267, 'molten', 6, 9, 0, 0, 0),
(10229, NULL, 2130, 257, 252, 'ice', 1, 9, 0, 0, 0),
(10230, NULL, 2130, 597, 340, 'ice', 1, 6, 0, 0, 0),
(10231, NULL, 2130, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10232, NULL, 2131, 565, 871, 'desert', 2, 6, 0, 0, 0),
(10233, NULL, 2131, 394, 310, 'volcanic', 5, 6, 0, 0, 0),
(10234, NULL, 2131, 30, 13, 'desert', 2, 6, 0, 0, 0),
(10235, 24, 2131, 475, 936, 'terran', 3, 6, 1, 1, 1),
(10236, NULL, 2131, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10237, NULL, 2132, 191, 779, 'molten', 6, 4, 0, 0, 0),
(10238, NULL, 2132, 474, 473, 'desert', 2, 4, 0, 0, 0),
(10239, NULL, 2132, 500, 500, 'redDwarf', 0, 6, 0, 0, 0),
(10240, NULL, 2133, 494, 577, 'molten', 6, 4, 0, 0, 0),
(10241, 24, 2133, 113, 650, 'terran', 3, 6, 1, 1, 1),
(10242, NULL, 2133, 500, 500, 'redDwarf', 0, 9, 0, 0, 0),
(10243, NULL, 2134, 390, 253, 'molten', 6, 4, 0, 0, 0),
(10244, NULL, 2134, 264, 149, 'desert', 2, 4, 0, 0, 0),
(10245, NULL, 2134, 500, 500, 'redDwarf', 0, 6, 0, 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2135 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `size`, `type`) VALUES
(2125, 1, 773, 98, 46, 'redGiant'),
(2126, 1, 307, 672, 30, 'blueGiant'),
(2127, 1, 134, 403, 46, 'redGiant'),
(2128, 1, 334, 151, 20, 'yellowStar'),
(2129, 1, 482, 614, 20, 'yellowStar'),
(2130, 1, 707, 722, 20, 'blueStar'),
(2131, 1, 177, 834, 20, 'blueStar'),
(2132, 1, 69, 846, 6, 'redDwarf'),
(2133, 1, 59, 925, 9, 'redDwarf'),
(2134, 1, 453, 550, 6, 'redDwarf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `username`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(18, 3, 1, '2q3o3CHLwvtDcLDe8xsM7g846NZ.zvfRC8c7PHHt', 'admin', 'NphdFxVrXT8ueLpZgNfUemtghjlj/iBJoKm8v3ec', 'e344575382996d08c8ad8bc6e809cd6e93216226249ce1ca70b038eac0341669d8f1985d5eeafbf57aee7236330ad208', 0, 0, 0, 0),
(24, 3, 0, 'gTwgSzD/fGObIqd9aW3dBOYzzcnu6AmaDQ/W4tjV', 'david.miller8@mohawkcollege.ca', 'xzpEmrZtfjBgzoxyrjV9vkFOnL1ctpz.OneCuUob', 'b5d95b79d96252d75168b0ccd5c9448902c65f439dba6b558e7aa6b724e486e22fa944148dacc332db57d2698b9b4b91', 0, 0, 0, 0);

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
