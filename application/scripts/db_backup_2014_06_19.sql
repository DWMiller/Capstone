-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 19, 2014 at 08:29 PM
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
(17, 'HHV7328D8afGlH2uX2JGmmdXtObDUw3mV1hVMjgM', '2014-06-16 05:05:13'),
(17, '.xDimmrNjLiokoEr9hcANrPu8AunTQfhSZ4CbzWF', '2014-06-16 05:05:55'),
(17, 'dAgGH8no4fclCz5sNDnpuRmGpa3kyT6IQjqq8Lg9', '2014-06-16 05:06:10'),
(17, 'Twa0CybcqHRafWvIcjTqo8KI8A6gqk0V/WT8woyY', '2014-06-16 05:06:20'),
(17, '6dBDbGb7vEsHW2wEHs/g9k5dIkfE2ccsPcKavhNv', '2014-06-16 05:06:34'),
(17, 'p1HUAG1DQQULTWdNw5sbcAigIzZiXDD2gX8NeKIW', '2014-06-16 05:09:27'),
(17, 'AfIBwG76o3ydGBd.rUazqCs4b56A6b8qt1O23De7', '2014-06-16 05:10:23'),
(17, 'yBS0rDPZTTG12nxaDUUHkBbSiSt2mkz/2jr7Fm3s', '2014-06-16 05:10:51'),
(17, 'Iev0XkQgta9C3n1gLohXImsnOznFE/6mHwWfRKCR', '2014-06-16 05:11:50'),
(17, 'V.fhMHFy7pRhy4p46wLmwzNhP2NRGgNhmlEDwAN2', '2014-06-16 05:12:18'),
(17, 'TTHLzD.5Wjxyt8EM62cvviqvN7xSg4QepQU0GQnY', '2014-06-16 05:13:16'),
(17, 'DQyHh/S3GP8/LpAYSZAwguLzs6rndvLmlIuSrfzf', '2014-06-16 05:13:58'),
(17, 'IN/fXq8EFZztgPh.bD2E8h7/XLoMjASSw38fMqXy', '2014-06-16 05:53:17'),
(17, 'h5OZy.QaQ05ojqR7Gle.L8mWR6IGdWk46TQ9oOLv', '2014-06-16 05:56:42'),
(17, '7Lhf0GUA8tWj7tcg6J6sLcvDDP/OFwfz1dQ.fHxR', '2014-06-16 05:59:03'),
(17, 'WfvbTfdx2koUGkKKPR7hd5BdSQ2Vv.rzKOrEs0rS', '2014-06-16 05:59:46'),
(17, 'Ob.QKZHe0VmdrGaRRO1f2af4V33N9TX21Fv.4tZz', '2014-06-16 06:00:14'),
(17, '7gAsMrsjVxdPuRIr57oQtVDFv.BXEq3OqzwrCtgX', '2014-06-16 06:01:11'),
(17, 'JX75f68sKAabBxib3Xt.FdM7bqKeL/.iI1ldln7f', '2014-06-16 06:08:59'),
(17, 'BgaIIZqvseiAZMK.o8xa004jxUdy0BhoILIyj9WY', '2014-06-16 06:09:13'),
(17, '0XOCAMrtVkKX0Wa2Uo.AdwBHHiTvcjrYx6bUepqh', '2014-06-16 06:09:56'),
(17, 'gXKazZ.e0ivcUroemUNHCyvrIBt8a0XWwtMHf4NZ', '2014-06-16 06:11:24'),
(17, 'VbxsscZsm9DQPuEiYy61gmUrqxY5Zf6rkeFEtpv7', '2014-06-16 06:11:47'),
(17, '0b2UYQ70MjW7DRwp0uyFMZoAdymaBivsnp3o98yG', '2014-06-16 06:13:41'),
(17, 'zRZt9hZBcLwe7eJpd9j5EsjOmcTf1yY0HZgsJNCh', '2014-06-16 06:15:57'),
(17, 'rRAa34dqSvy/CIVdRSs1eTtI12YsHftqrzZlv9bx', '2014-06-16 06:19:25'),
(17, 'pgN.s9Tw8fQ7Zi3Hg6MM9o8t6Y6tsC.WkJhtymA7', '2014-06-16 06:21:20'),
(17, '6NEbsk/8tySjLiPaAUf.2KGlfH7fNOjzpj6pNapC', '2014-06-16 06:24:12'),
(17, '/djon8TcNOqfQvtyt80EyL0rAMUGUafou8PfDtdn', '2014-06-16 06:40:42'),
(17, 'VH1DAtGskb073B0ugxVA90HDHcQpiimw6x093gIn', '2014-06-16 06:41:12'),
(17, 'TCeDTeMifOp6CKxPyV0wdJbPAOIT.ml9.PkhgW3U', '2014-06-16 06:57:10'),
(17, 'k1z5kI1xFwmElTmC24KOEmUNgjW2VslwDsZfZ8h5', '2014-06-16 06:57:33'),
(17, 'yIeMQEAou7k3LY1I8.TUXgn1qRrgELLYBnPT.mHA', '2014-06-16 06:59:08'),
(17, 'WUPIGzghA53ZPnqc/t/PTGfdxG0aBtw9kzMXeMVl', '2014-06-16 07:00:31'),
(17, 'WBZxvSQce3CQbsgUPraPhq3T0he.3vIkhrMMlBiZ', '2014-06-16 07:01:28'),
(17, 'I9MmFrkKvJD6/qCILhI89MtVFH74NjW.1MCtYe/e', '2014-06-16 07:09:06'),
(17, 'mq8uoCNdYBd8QdMF48njlM5fbXBDa0SiNjkiwWoz', '2014-06-16 07:09:54'),
(17, 'Osr/aOgGkXLiEK32diIFcrgsO1eiA3Wy0IzrR6Jl', '2014-06-16 20:00:10'),
(17, 'AnfcZ.WNK7RZMjkmWY8H2Txgx3TLsuyrsvV0bsuO', '2014-06-16 20:04:26'),
(17, '7QduT1X.mZIO.QBdS5MODTnD02LozyxyRNXp6LbG', '2014-06-16 20:05:34'),
(17, 'iCQg2sRvVnyn5WOvN.skfiKZxSlbvKR0AmRUcwro', '2014-06-16 22:22:16'),
(17, 'otjcScOQt/LdbmEOXlOumVAT6tXB/HI3cdvjnMfx', '2014-06-16 23:43:11'),
(17, 'mZBYL6k9rF30fuicoPa3cBpor2PCA05V5Vice6ok', '2014-06-16 23:43:37'),
(17, 'zizBsGh8ghvhuG3HXtIdVcmyINiLUTsr3Mqym9IZ', '2014-06-16 23:58:03'),
(17, 'hnfrXx1HOpqg92r.B/R2kS3M0Gui1w5M8VFqqnQ0', '2014-06-16 20:00:05'),
(17, 'mkLJQ8AcCJGq9Ws71uBHc6kpzLKBaWXIvVw3VhPF', '2014-06-16 20:48:07'),
(17, 'yVcbSr565X2dqPmyyIm2qG9AQ4TQ2uNY4KeIiOOQ', '2014-06-17 05:05:37'),
(17, 'aTIItscdsxZQP0YRveBoYqJ2V4lN4L571HQxOJ.P', '2014-06-17 05:26:18'),
(17, 'JprOOtu5xJ46qlSpmlrUonDKabnWlDdI39tJLH2R', '2014-06-17 05:26:40'),
(17, '13YSLcIKjtniEyyUBDosD75O2WZMHaQ6IDkGe4YH', '2014-06-17 05:28:51'),
(17, 'H1Tj9uw76zYRz1LhFbuGOpMNp8SGEJLkNwCRxx6e', '2014-06-17 05:31:45'),
(17, 'N0FHfv96rvyWqbTyCd0WZkIo67tfSvLHjNH1.czw', '2014-06-17 05:43:16'),
(17, 'NyGEgCPRf3zC1EVR21ao6nzEaDLLaL1rDCnAu3G0', '2014-06-17 05:44:17'),
(17, 'nT7qM6gtx.aljrj2lqjIhGPs.IBesa7YEZ.DhBZF', '2014-06-17 05:45:09'),
(17, '2jD2JLYgwXEnoLo110XvCznExeKkIGBjUjACVaho', '2014-06-17 05:49:42'),
(17, 'OoN31zpdbTMz9/0F9o5Herdqzdkw8r5cVAwAAh3G', '2014-06-17 05:51:30'),
(17, 'mGGHyBig3NL2lV96ETqP5U/67Zph7L2VVbhhNS7V', '2014-06-17 05:55:29'),
(17, 'ynefjNJGmIWcLeG9NBREq2tvGQYxsgN1WcVs9QNd', '2014-06-17 06:00:10'),
(17, '6jj10NbOy8dNTct.95Az.TJUs8IKVkXgd6hGeCZU', '2014-06-17 06:03:15'),
(17, 'ahQaSr6VAny9dOidbHozVIVGhBJWawfcvbWlLFBI', '2014-06-17 06:03:44'),
(17, 'W.QLnOmx6qxXXj9DD80nhTyj.70mxPh5TDrtJNmc', '2014-06-18 13:55:02'),
(17, 'nI/Au075teAdnM7fPgdFZrrzUcaSvEjSUJvEsH2t', '2014-06-18 14:23:01'),
(17, 'G0veSqTY4eYaR9gS11p3Ruthv3yYT.FrsvV14v.O', '2014-06-18 14:30:10'),
(17, 'tQG7KgCBfh6WxHKsR5iismLczXaxU4PuvOejOZb2', '2014-06-18 14:33:03'),
(17, '/luXkgFXD7llPO46tLtb6dPdjxgtyH66t0Oz2l7O', '2014-06-18 14:33:58'),
(17, 'uHpgabDjuDdjR7wrEY2ysNA783vqnWgm1xuVT8dV', '2014-06-18 14:38:10'),
(17, '22rY1YF6LyulUGfqbGvCeH.DkdjBC32J.c3QwkEc', '2014-06-18 14:38:42'),
(17, 'KXULXREh1jLRFwz1473pzx0K7EBMB76scZYpJy/s', '2014-06-18 14:39:18'),
(17, 'i.XgtpCE1rZRBhOL5OVu5oyEilyt/FGqUAJLTp2U', '2014-06-18 14:40:03'),
(17, 'zl6Mp0wdhJm2QA18c52vhz/h/ahRzqRZrPKoM1mk', '2014-06-18 14:40:51'),
(17, '.nLbnQ.sWqYDrWAvT46pfrWsdTgYfDzrT0fLAiLT', '2014-06-19 18:23:09'),
(17, 'eeULxW9utHm7NTlGP2.vgEsediyWtk2oYDo79wrn', '2014-06-19 18:24:29'),
(17, '9sslLYntIZKixDOluyP0b/mUNdKWsucqJ3zphERc', '2014-06-19 18:30:38'),
(17, 'JfYfHazd1puk08ZWAlCMj6Xy8BHHmEByqUr8vBHQ', '2014-06-19 18:33:47'),
(17, 'xVpufoMxhcaCC0Mmtb3yZGNMj/IOHwsHJCr8DLwP', '2014-06-19 18:35:19'),
(17, 'd1o9KL28pj.TYA71BsNlgvkgJ5NiZqBJtRy6nbOV', '2014-06-19 18:38:16'),
(17, '/2o0wCy9U/wP0YKBS/a/xOpyYFAHj9X2qh/b1FsC', '2014-06-19 18:38:40'),
(17, 'Wbrbk9THgwt3HCwjaiPdVrLVEsFv.C/Pm15XH3jd', '2014-06-19 19:12:57'),
(17, '5INWlnoHrVgDM.T8RHGVB9qOyOOOLHU8lqi90chK', '2014-06-19 19:53:28'),
(17, 'Q4MlsJ7l5FP/BGEm/lPyxK0by7SNr2Yqsp2tMo3a', '2014-06-19 19:59:08'),
(17, 'kV712qZmMu71oNXtqkic9YxNqo5Ztyhw4CivGtEE', '2014-06-19 19:59:47'),
(17, '4nn6n4aLTE.W9c37AslMTjSXZ1POtEwQ94YGIUJ0', '2014-06-19 20:02:21'),
(17, 'lVqUS7/6cHwwXvbD9SsnPOdbosP1.0CkWQZbC94R', '2014-06-19 20:09:18'),
(17, 'NSeS5Yh9KW3TUbR9.vq9aEoeoKf9gJsZWZmWsWOt', '2014-06-19 20:09:37'),
(17, 'fzmlrYwHXMt/bRztVgJEm1G0/RTglPNt1wJKBNzL', '2014-06-19 20:29:06'),
(17, '1In1h/tSeK7rx9EoQ7RU90e8886HJZE144KWXsYh', '2014-06-19 20:34:53'),
(17, 'FCF9vB0.PYOwyFn0z/TYEBiHHAylo/GziTO2IXda', '2014-06-19 20:35:11'),
(17, 'YNIVxE.conQUhxDkbcwuyGwz6gUYJp4olTicKtdK', '2014-06-19 20:37:40');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7879 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(7783, NULL, 1633, 439, 329, 'ice', 1, 9, 0, 0, 0),
(7784, NULL, 1633, 229, 27, 'volcanic', 5, 9, 0, 0, 0),
(7785, NULL, 1633, 676, 525, 'volcanic', 5, 14, 0, 0, 0),
(7786, NULL, 1633, 681, 613, 'molten', 6, 9, 0, 0, 0),
(7787, NULL, 1633, 992, 76, 'terran', 3, 4, 0, 0, 0),
(7788, NULL, 1633, 665, 644, 'volcanic', 5, 4, 0, 0, 0),
(7789, NULL, 1633, 500, 500, 'redGiant', 0, 46, 0, 0, 0),
(7790, NULL, 1634, 56, 621, 'volcanic', 5, 9, 0, 0, 0),
(7791, NULL, 1634, 946, 385, 'molten', 6, 9, 0, 0, 0),
(7792, NULL, 1634, 140, 62, 'desert', 2, 4, 0, 0, 0),
(7793, NULL, 1634, 212, 170, 'volcanic', 5, 9, 0, 0, 0),
(7794, NULL, 1634, 500, 500, 'redGiant', 0, 30, 0, 0, 0),
(7795, NULL, 1635, 381, 257, 'molten', 6, 9, 0, 0, 0),
(7796, NULL, 1635, 275, 226, 'ice', 1, 9, 0, 0, 0),
(7797, NULL, 1635, 146, 822, 'terran', 3, 6, 0, 0, 0),
(7798, NULL, 1635, 52, 291, 'desert', 2, 9, 0, 0, 0),
(7799, NULL, 1635, 977, 23, 'molten', 6, 9, 0, 0, 0),
(7800, NULL, 1635, 472, 891, 'volcanic', 5, 4, 0, 0, 0),
(7801, NULL, 1635, 500, 500, 'blueGiant', 0, 46, 0, 0, 0),
(7802, NULL, 1636, 95, 276, 'gasGiant', 0, 20, 0, 0, 0),
(7803, NULL, 1636, 629, 571, 'molten', 6, 9, 0, 0, 0),
(7804, NULL, 1636, 882, 805, 'molten', 6, 9, 0, 0, 0),
(7805, NULL, 1636, 907, 410, 'molten', 6, 14, 0, 0, 0),
(7806, NULL, 1636, 932, 64, 'ice', 1, 6, 0, 0, 0),
(7807, NULL, 1636, 604, 972, 'volcanic', 5, 14, 0, 0, 0),
(7808, NULL, 1636, 500, 500, 'blueHyperGiant', 0, 68, 0, 0, 0),
(7809, NULL, 1637, 851, 270, 'gasGiant', 0, 20, 0, 0, 0),
(7810, NULL, 1637, 39, 29, 'desert', 2, 14, 0, 0, 0),
(7811, NULL, 1637, 304, 360, 'terran', 3, 9, 0, 0, 0),
(7812, NULL, 1637, 835, 584, 'desert', 2, 14, 0, 0, 0),
(7813, NULL, 1637, 821, 60, 'desert', 2, 9, 0, 0, 0),
(7814, NULL, 1637, 733, 94, 'volcanic', 5, 9, 0, 0, 0),
(7815, NULL, 1637, 500, 500, 'blueHyperGiant', 0, 68, 0, 0, 0),
(7816, NULL, 1638, 884, 729, 'desert', 2, 9, 0, 0, 0),
(7817, NULL, 1638, 254, 10, 'volcanic', 5, 14, 0, 0, 0),
(7818, NULL, 1638, 885, 508, 'volcanic', 5, 6, 0, 0, 0),
(7819, NULL, 1638, 327, 848, 'molten', 6, 6, 0, 0, 0),
(7820, NULL, 1638, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(7821, NULL, 1639, 761, 767, 'ice', 1, 6, 0, 0, 0),
(7822, NULL, 1639, 900, 923, 'desert', 2, 9, 0, 0, 0),
(7823, NULL, 1639, 89, 685, 'molten', 6, 9, 0, 0, 0),
(7824, NULL, 1639, 978, 490, 'volcanic', 5, 4, 0, 0, 0),
(7825, NULL, 1639, 793, 317, 'terran', 3, 14, 0, 0, 0),
(7826, NULL, 1639, 75, 639, 'terran', 3, 6, 0, 0, 0),
(7827, NULL, 1639, 500, 500, 'redGiant', 0, 46, 0, 0, 0),
(7828, NULL, 1640, 778, 384, 'volcanic', 5, 14, 0, 0, 0),
(7829, NULL, 1640, 176, 443, 'molten', 6, 9, 0, 0, 0),
(7830, NULL, 1640, 244, 161, 'ice', 1, 6, 0, 0, 0),
(7831, NULL, 1640, 70, 700, 'volcanic', 5, 14, 0, 0, 0),
(7832, NULL, 1640, 32, 362, 'terran', 3, 4, 0, 0, 0),
(7833, NULL, 1640, 268, 666, 'molten', 6, 4, 0, 0, 0),
(7834, NULL, 1640, 500, 500, 'redGiant', 0, 46, 0, 0, 0),
(7835, NULL, 1641, 300, 577, 'ice', 1, 9, 0, 0, 0),
(7836, NULL, 1641, 404, 940, 'ice', 1, 6, 0, 0, 0),
(7837, NULL, 1641, 859, 277, 'molten', 6, 9, 0, 0, 0),
(7838, NULL, 1641, 507, 736, 'terran', 3, 9, 0, 0, 0),
(7839, NULL, 1641, 665, 993, 'volcanic', 5, 4, 0, 0, 0),
(7840, NULL, 1641, 1000, 836, 'terran', 3, 6, 0, 0, 0),
(7841, NULL, 1641, 39, 444, 'volcanic', 5, 4, 0, 0, 0),
(7842, NULL, 1641, 500, 500, 'blueGiant', 0, 46, 0, 0, 0),
(7843, NULL, 1642, 939, 665, 'terran', 3, 14, 0, 0, 0),
(7844, NULL, 1642, 755, 91, 'desert', 2, 9, 0, 0, 0),
(7845, NULL, 1642, 765, 972, 'terran', 3, 4, 0, 0, 0),
(7846, NULL, 1642, 508, 852, 'molten', 6, 6, 0, 0, 0),
(7847, NULL, 1642, 918, 800, 'gasGiant', 0, 20, 0, 0, 0),
(7848, NULL, 1642, 414, 352, 'molten', 6, 6, 0, 0, 0),
(7849, NULL, 1642, 600, 631, 'volcanic', 5, 6, 0, 0, 0),
(7850, NULL, 1642, 705, 340, 'desert', 2, 9, 0, 0, 0),
(7851, NULL, 1642, 500, 500, 'blueHyperGiant', 0, 68, 0, 0, 0),
(7852, NULL, 1643, 20, 336, 'ice', 1, 6, 0, 0, 0),
(7853, NULL, 1643, 674, 911, 'volcanic', 5, 6, 0, 0, 0),
(7854, NULL, 1643, 489, 638, 'molten', 6, 4, 0, 0, 0),
(7855, NULL, 1643, 571, 42, 'terran', 3, 6, 0, 0, 0),
(7856, NULL, 1643, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(7857, NULL, 1644, 896, 333, 'volcanic', 5, 6, 0, 0, 0),
(7858, NULL, 1644, 959, 776, 'desert', 2, 6, 0, 0, 0),
(7859, NULL, 1644, 637, 464, 'terran', 3, 6, 0, 0, 0),
(7860, NULL, 1644, 790, 455, 'molten', 6, 9, 0, 0, 0),
(7861, NULL, 1644, 908, 784, 'ice', 1, 6, 0, 0, 0),
(7862, NULL, 1644, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(7863, NULL, 1645, 68, 539, 'terran', 3, 9, 0, 0, 0),
(7864, NULL, 1645, 259, 859, 'terran', 3, 4, 0, 0, 0),
(7865, NULL, 1645, 655, 364, 'desert', 2, 14, 0, 0, 0),
(7866, NULL, 1645, 67, 239, 'desert', 2, 6, 0, 0, 0),
(7867, NULL, 1645, 940, 347, 'volcanic', 5, 6, 0, 0, 0),
(7868, NULL, 1645, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(7869, NULL, 1646, 676, 985, 'ice', 1, 6, 0, 0, 0),
(7870, NULL, 1646, 430, 728, 'molten', 6, 4, 0, 0, 0),
(7871, NULL, 1646, 885, 211, 'volcanic', 5, 4, 0, 0, 0),
(7872, NULL, 1646, 500, 500, 'yellowStar', 0, 14, 0, 0, 0),
(7873, NULL, 1647, 992, 953, 'molten', 6, 4, 0, 0, 0),
(7874, NULL, 1647, 24, 840, 'volcanic', 5, 4, 0, 0, 0),
(7875, NULL, 1647, 121, 504, 'molten', 6, 6, 0, 0, 0),
(7876, NULL, 1647, 500, 500, 'yellowStar', 0, 14, 0, 0, 0),
(7877, NULL, 1648, 770, 650, 'ice', 1, 4, 0, 0, 0),
(7878, NULL, 1648, 500, 500, 'whiteDwarf', 0, 4, 0, 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1649 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `size`, `type`) VALUES
(1633, 1, 40, 85, 46, 'redGiant'),
(1634, 1, 38, 26, 30, 'redGiant'),
(1635, 1, 23, 74, 46, 'blueGiant'),
(1636, 1, 26, 8, 68, 'blueHyperGiant'),
(1637, 1, 84, 44, 68, 'blueHyperGiant'),
(1638, 1, 3, 9, 30, 'blueGiant'),
(1639, 1, 6, 33, 46, 'redGiant'),
(1640, 1, 0, 76, 46, 'redGiant'),
(1641, 1, 93, 23, 46, 'blueGiant'),
(1642, 1, 98, 20, 68, 'blueHyperGiant'),
(1643, 1, 49, 81, 20, 'yellowStar'),
(1644, 1, 13, 28, 30, 'blueGiant'),
(1645, 1, 82, 98, 30, 'blueGiant'),
(1646, 1, 28, 80, 14, 'yellowStar'),
(1647, 1, 64, 71, 14, 'yellowStar'),
(1648, 1, 34, 42, 4, 'whiteDwarf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) NOT NULL DEFAULT '0',
  `username` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `salt` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `resources` int(10) NOT NULL,
  `tech_weapons` tinyint(3) NOT NULL DEFAULT '0',
  `tech_propulsion` tinyint(3) NOT NULL DEFAULT '0',
  `tech_armour` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `username`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(17, 2, 'GV.W3IQU1v8t3dh4Le4CJ0HVEoPnxYwR23liG6HI', 'root', 'IidIfQKi1GjEZx4GoD7nsJqGKHePWM1zvSpXHzL8', 'c3654fba631e654cf618a15dcb5cedcbdbbe2058b7042e784023daf0ea709f687a93056e2423b17cf44b3f0082150602', 0, 0, 0, 0);

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
