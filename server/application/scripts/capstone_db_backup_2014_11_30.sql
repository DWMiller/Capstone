-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 30, 2014 at 07:27 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `active_sessions`
--

INSERT INTO `active_sessions` (`id`, `user_id`, `ip`, `session`, `expires`) VALUES
(19, 1, 0, 'itW1PD4XGA6bUUvNGL2kAgTKX6UoSlHJKzcnMcTP', '2014-11-30 19:58:59');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=175 ;

--
-- Dumping data for table `battle_logs`
--

INSERT INTO `battle_logs` (`id`, `timestamp`, `location_id`, `player1_id`, `player2_id`, `player1_roll`, `player2_roll`, `player1_bonus_roll`, `player2_bonus_roll`, `player1_bonus_roll2`, `player2_bonus_roll2`, `player1_losses`, `player2_losses`) VALUES
(1, '2014-11-30 18:53:28', 23, 3, 1, 0, 0, 0, 0, 0, 0, 7, 9),
(2, '2014-11-30 18:53:31', 23, 3, 1, 0, 0, 0, 0, 0, 0, 6, 8),
(3, '2014-11-30 18:53:34', 23, 3, 1, 0, 0, 0, 0, 0, 0, 6, 7),
(4, '2014-11-30 18:53:37', 23, 3, 1, 0, 0, 0, 0, 0, 0, 5, 7),
(5, '2014-11-30 18:53:40', 23, 3, 1, 0, 0, 0, 0, 0, 0, 5, 6),
(6, '2014-11-30 18:53:43', 23, 3, 1, 0, 0, 0, 0, 0, 0, 4, 5),
(7, '2014-11-30 18:54:55', 28, 4, 1, 0, 0, 0, 0, 0, 0, 7, 9),
(8, '2014-11-30 18:54:58', 28, 4, 1, 0, 0, 0, 0, 0, 0, 7, 9),
(9, '2014-11-30 18:55:01', 28, 4, 1, 0, 0, 0, 0, 0, 0, 6, 8),
(10, '2014-11-30 18:55:28', 22, 2, 1, 0, 0, 0, 0, 0, 0, 8, 10),
(11, '2014-11-30 18:55:31', 22, 2, 1, 0, 0, 0, 0, 0, 1, 7, 9),
(12, '2014-11-30 18:55:34', 22, 2, 1, 0, 1, 0, 1, 0, 0, 8, 5),
(13, '2014-11-30 18:55:37', 22, 2, 1, 0, 0, 0, 1, 0, 0, 6, 6),
(14, '2014-11-30 18:56:22', 23, 1, 3, 1, 0, 0, 0, 0, 0, 10, 12),
(15, '2014-11-30 18:56:25', 23, 1, 3, 0, 0, 1, 0, 1, 0, 6, 10),
(16, '2014-11-30 18:56:25', 23, 1, 1, 1, 0, 1, 1, 1, 0, 6, 9),
(17, '2014-11-30 18:56:26', 23, 3, 1, 0, 0, 0, 0, 0, 0, 7, 9),
(18, '2014-11-30 18:56:28', 23, 1, 3, 1, 0, 1, 0, 0, 0, 7, 9),
(19, '2014-11-30 18:56:28', 23, 1, 1, 1, 0, 1, 1, 1, 1, 6, 8),
(20, '2014-11-30 18:56:28', 23, 3, 1, 0, 1, 0, 0, 0, 1, 8, 6),
(21, '2014-11-30 18:56:31', 22, 2, 1, 0, 1, 0, 0, 0, 0, 9, 8),
(22, '2014-11-30 18:56:31', 23, 3, 1, 0, 1, 0, 2, 0, 1, 6, 4),
(23, '2014-11-30 18:56:34', 22, 2, 1, 0, 0, 0, 1, 0, 2, 7, 7),
(24, '2014-11-30 18:56:34', 23, 3, 1, 0, 1, 0, 2, 0, 2, 6, 3),
(25, '2014-11-30 18:56:37', 22, 2, 1, 0, 2, 0, 1, 0, 1, 8, 5),
(26, '2014-11-30 18:56:37', 23, 3, 1, 0, 1, 0, 0, 0, 2, 5, 4),
(27, '2014-11-30 18:56:40', 22, 2, 1, 0, 0, 0, 2, 0, 1, 6, 6),
(28, '2014-11-30 18:56:40', 23, 3, 1, 0, 1, 0, 0, 0, 1, 4, 3),
(29, '2014-11-30 18:56:43', 22, 2, 1, 0, 2, 0, 0, 0, 1, 7, 6),
(30, '2014-11-30 18:56:43', 23, 3, 1, 0, 2, 0, 0, 0, 0, 4, 3),
(31, '2014-11-30 18:56:46', 22, 2, 1, 0, 0, 0, 1, 0, 2, 5, 5),
(32, '2014-11-30 18:56:46', 23, 3, 1, 0, 2, 0, 1, 0, 1, 3, 2),
(33, '2014-11-30 18:56:49', 23, 3, 1, 0, 1, 0, 1, 0, 1, 2, 1),
(34, '2014-11-30 18:57:49', 22, 2, 1, 0, 1, 0, 1, 0, 2, 9, 5),
(35, '2014-11-30 18:57:52', 22, 2, 1, 0, 2, 0, 2, 0, 0, 8, 5),
(36, '2014-11-30 18:57:52', 23, 1, 3, 2, 0, 1, 0, 0, 0, 6, 7),
(37, '2014-11-30 18:57:55', 22, 2, 1, 0, 2, 0, 0, 0, 2, 8, 6),
(38, '2014-11-30 18:57:55', 23, 1, 3, 2, 0, 0, 0, 2, 0, 4, 6),
(39, '2014-11-30 18:57:58', 22, 2, 1, 0, 0, 0, 1, 0, 1, 6, 6),
(40, '2014-11-30 18:57:58', 23, 1, 3, 2, 0, 2, 0, 2, 0, 4, 6),
(41, '2014-11-30 18:58:01', 22, 2, 1, 0, 0, 0, 0, 0, 2, 5, 7),
(42, '2014-11-30 18:58:01', 23, 1, 3, 0, 0, 1, 0, 1, 0, 3, 5),
(43, '2014-11-30 18:58:04', 22, 2, 1, 0, 2, 0, 2, 0, 2, 6, 4),
(44, '2014-11-30 18:58:07', 22, 2, 1, 0, 2, 0, 1, 0, 0, 5, 3),
(45, '2014-11-30 18:58:10', 22, 2, 1, 0, 0, 0, 2, 0, 1, 4, 3),
(46, '2014-11-30 18:58:13', 22, 2, 1, 0, 0, 0, 0, 0, 0, 3, 4),
(47, '2014-11-30 18:58:16', 22, 2, 1, 0, 2, 0, 2, 0, 0, 4, 2),
(48, '2014-11-30 18:58:19', 22, 2, 1, 0, 2, 0, 0, 0, 0, 3, 2),
(49, '2014-11-30 18:58:22', 22, 2, 1, 0, 2, 0, 0, 0, 1, 2, 2),
(50, '2014-11-30 18:58:37', 22, 1, 2, 1, 0, 1, 0, 1, 0, 2, 4),
(51, '2014-11-30 18:58:40', 22, 1, 2, 0, 0, 1, 0, 2, 0, 2, 3),
(52, '2014-11-30 18:58:49', 19, 1, 1, 2, 1, 0, 0, 1, 0, 3, 4),
(53, '2014-11-30 19:01:20', 28, 4, 1, 0, 2, 0, 0, 0, 2, 24, 19),
(54, '2014-11-30 19:01:23', 28, 4, 1, 0, 0, 0, 2, 0, 2, 21, 20),
(55, '2014-11-30 19:01:26', 28, 4, 1, 0, 1, 0, 0, 0, 1, 26, 21),
(56, '2014-11-30 19:01:29', 28, 4, 1, 0, 0, 0, 2, 0, 0, 20, 19),
(57, '2014-11-30 19:01:32', 28, 4, 1, 0, 1, 0, 1, 0, 1, 25, 15),
(58, '2014-11-30 19:01:35', 28, 4, 1, 0, 0, 0, 2, 0, 0, 20, 19),
(59, '2014-11-30 19:01:38', 28, 4, 1, 0, 2, 0, 2, 0, 0, 25, 15),
(60, '2014-11-30 19:01:41', 28, 4, 1, 0, 0, 0, 2, 0, 0, 19, 18),
(61, '2014-11-30 19:01:44', 28, 4, 1, 0, 2, 0, 1, 0, 0, 24, 14),
(62, '2014-11-30 19:01:47', 28, 4, 1, 0, 1, 0, 0, 0, 2, 23, 18),
(63, '2014-11-30 19:01:50', 28, 4, 1, 0, 0, 0, 2, 0, 0, 19, 18),
(64, '2014-11-30 19:01:53', 28, 4, 1, 0, 2, 0, 2, 0, 0, 23, 14),
(65, '2014-11-30 19:01:56', 28, 4, 1, 0, 2, 0, 2, 0, 1, 22, 13),
(66, '2014-11-30 19:01:59', 28, 4, 1, 0, 0, 0, 2, 0, 0, 17, 16),
(67, '2014-11-30 19:02:02', 28, 4, 1, 0, 2, 0, 0, 0, 0, 21, 17),
(68, '2014-11-30 19:02:05', 28, 4, 1, 0, 1, 0, 2, 0, 2, 22, 13),
(69, '2014-11-30 19:02:08', 28, 4, 1, 0, 2, 0, 0, 0, 2, 21, 17),
(70, '2014-11-30 19:02:11', 28, 4, 1, 0, 0, 0, 0, 0, 0, 16, 21),
(71, '2014-11-30 19:02:14', 28, 4, 1, 0, 1, 0, 1, 0, 2, 20, 12),
(72, '2014-11-30 19:02:17', 28, 4, 1, 0, 0, 0, 1, 0, 0, 15, 14),
(73, '2014-11-30 19:02:20', 28, 4, 1, 0, 2, 0, 1, 0, 0, 19, 11),
(74, '2014-11-30 19:02:23', 28, 4, 1, 0, 2, 0, 0, 0, 0, 20, 16),
(75, '2014-11-30 19:02:56', 28, 4, 1, 0, 2, 0, 2, 0, 2, 22, 13),
(76, '2014-11-30 19:02:59', 28, 4, 1, 0, 1, 0, 0, 0, 1, 22, 18),
(77, '2014-11-30 19:03:05', 28, 4, 1, 0, 0, 0, 0, 0, 1, 19, 24),
(78, '2014-11-30 19:03:08', 28, 4, 1, 0, 0, 0, 1, 0, 2, 25, 23),
(79, '2014-11-30 19:03:11', 28, 4, 1, 0, 0, 0, 1, 0, 1, 24, 23),
(80, '2014-11-30 19:03:14', 28, 4, 1, 0, 1, 0, 0, 0, 1, 30, 24),
(81, '2014-11-30 19:03:17', 28, 4, 1, 0, 1, 0, 0, 0, 0, 29, 23),
(82, '2014-11-30 19:03:20', 28, 4, 1, 0, 2, 0, 2, 0, 1, 30, 18),
(83, '2014-11-30 19:03:23', 28, 4, 1, 0, 2, 0, 2, 0, 2, 29, 17),
(84, '2014-11-30 19:03:26', 28, 4, 1, 0, 0, 0, 1, 0, 2, 23, 21),
(85, '2014-11-30 19:03:29', 28, 4, 1, 0, 2, 0, 0, 0, 2, 28, 22),
(86, '2014-11-30 19:03:32', 28, 4, 1, 0, 2, 0, 0, 0, 1, 27, 22),
(87, '2014-11-30 19:03:35', 9, 1, 1, 0, 1, 2, 1, 1, 0, 3, 3),
(88, '2014-11-30 19:03:35', 28, 4, 1, 0, 1, 0, 1, 0, 0, 28, 17),
(89, '2014-11-30 19:03:38', 28, 4, 1, 0, 1, 0, 2, 0, 2, 27, 16),
(90, '2014-11-30 19:03:41', 28, 4, 1, 0, 1, 0, 1, 0, 0, 26, 16),
(91, '2014-11-30 19:03:44', 28, 4, 1, 0, 0, 0, 2, 0, 2, 20, 19),
(92, '2014-11-30 19:03:47', 28, 4, 1, 0, 2, 0, 2, 0, 1, 25, 15),
(93, '2014-11-30 19:03:50', 28, 4, 1, 0, 1, 0, 2, 0, 1, 26, 15),
(94, '2014-11-30 19:03:53', 28, 4, 1, 0, 0, 0, 1, 0, 0, 20, 19),
(95, '2014-11-30 19:03:56', 28, 4, 1, 0, 0, 0, 1, 0, 2, 19, 18),
(96, '2014-11-30 19:03:59', 28, 4, 1, 0, 0, 0, 1, 0, 2, 19, 18),
(97, '2014-11-30 19:04:02', 28, 4, 1, 0, 2, 0, 0, 0, 0, 23, 19),
(98, '2014-11-30 19:04:05', 28, 4, 1, 0, 1, 0, 0, 0, 1, 24, 19),
(99, '2014-11-30 19:04:08', 28, 4, 1, 0, 0, 0, 2, 0, 2, 18, 17),
(100, '2014-11-30 19:04:11', 28, 4, 1, 0, 2, 0, 2, 0, 2, 22, 13),
(101, '2014-11-30 19:04:14', 28, 4, 1, 0, 2, 0, 0, 0, 2, 22, 17),
(102, '2014-11-30 19:04:17', 28, 4, 1, 0, 1, 0, 2, 0, 1, 21, 13),
(103, '2014-11-30 19:04:20', 28, 4, 1, 0, 1, 0, 2, 0, 2, 22, 13),
(104, '2014-11-30 19:04:23', 28, 4, 1, 0, 0, 0, 0, 0, 2, 17, 21),
(105, '2014-11-30 19:04:26', 28, 4, 1, 0, 1, 0, 2, 0, 1, 21, 12),
(106, '2014-11-30 19:04:29', 28, 4, 1, 0, 2, 0, 2, 0, 2, 20, 12),
(107, '2014-11-30 19:04:32', 28, 4, 1, 0, 0, 0, 2, 0, 2, 15, 15),
(108, '2014-11-30 19:04:35', 28, 4, 1, 0, 2, 0, 1, 0, 1, 20, 12),
(109, '2014-11-30 19:04:38', 28, 4, 1, 0, 2, 0, 0, 0, 0, 20, 16),
(110, '2014-11-30 19:04:41', 28, 4, 1, 0, 0, 0, 0, 0, 1, 15, 19),
(111, '2014-11-30 19:04:44', 28, 4, 1, 0, 0, 0, 1, 0, 1, 15, 14),
(112, '2014-11-30 19:04:47', 28, 4, 1, 0, 0, 0, 1, 0, 0, 14, 13),
(113, '2014-11-30 19:04:50', 28, 4, 1, 0, 0, 0, 0, 0, 2, 15, 19),
(114, '2014-11-30 19:05:50', 28, 4, 1, 0, 6, 0, 3, 0, 0, 29, 17),
(115, '2014-11-30 19:05:53', 28, 4, 1, 0, 0, 0, 0, 0, 2, 23, 29),
(116, '2014-11-30 19:05:56', 28, 4, 1, 0, 5, 0, 2, 0, 7, 28, 17),
(117, '2014-11-30 19:05:59', 28, 4, 1, 0, 2, 0, 4, 0, 7, 27, 16),
(118, '2014-11-30 19:06:02', 19, 1, 1, 1, 8, 3, 3, 0, 3, 13, 10),
(119, '2014-11-30 19:06:02', 28, 4, 1, 0, 2, 0, 3, 0, 0, 27, 16),
(120, '2014-11-30 19:06:05', 28, 4, 1, 0, 7, 0, 1, 0, 5, 27, 16),
(121, '2014-11-30 19:06:08', 28, 4, 1, 0, 6, 0, 0, 0, 3, 26, 21),
(122, '2014-11-30 19:06:11', 28, 4, 1, 0, 0, 0, 3, 0, 5, 21, 19),
(123, '2014-11-30 19:06:14', 9, 1, 1, 5, 8, 8, 2, 3, 2, 4, 4),
(124, '2014-11-30 19:06:14', 28, 4, 1, 0, 4, 0, 3, 0, 5, 25, 15),
(125, '2014-11-30 19:06:17', 28, 4, 1, 0, 2, 0, 4, 0, 5, 25, 15),
(126, '2014-11-30 19:06:20', 28, 4, 1, 0, 7, 0, 4, 0, 4, 25, 15),
(127, '2014-11-30 19:06:23', 28, 4, 1, 0, 3, 0, 1, 0, 1, 25, 15),
(128, '2014-11-30 19:06:26', 28, 4, 1, 0, 4, 0, 3, 0, 4, 24, 14),
(129, '2014-11-30 19:06:29', 28, 4, 1, 0, 8, 0, 3, 0, 6, 23, 14),
(130, '2014-11-30 19:06:32', 28, 4, 1, 0, 6, 0, 4, 0, 1, 23, 14),
(131, '2014-11-30 19:06:35', 28, 4, 1, 0, 6, 0, 1, 0, 6, 23, 14),
(132, '2014-11-30 19:06:38', 28, 4, 1, 0, 4, 0, 0, 0, 2, 23, 18),
(133, '2014-11-30 19:06:41', 28, 4, 1, 0, 7, 0, 3, 0, 6, 22, 13),
(134, '2014-11-30 19:06:44', 28, 1, 4, 2, 0, 5, 0, 0, 0, 27, 34),
(135, '2014-11-30 19:06:47', 28, 1, 4, 1, 0, 4, 0, 4, 0, 20, 33),
(136, '2014-11-30 19:06:50', 28, 1, 4, 8, 0, 6, 0, 1, 0, 20, 33),
(137, '2014-11-30 19:06:53', 28, 1, 4, 5, 0, 4, 0, 2, 0, 20, 33),
(138, '2014-11-30 19:06:56', 28, 1, 4, 7, 0, 4, 0, 4, 0, 19, 32),
(139, '2014-11-30 19:06:59', 28, 1, 4, 8, 0, 7, 0, 4, 0, 19, 31),
(140, '2014-11-30 19:07:02', 28, 1, 4, 0, 0, 8, 0, 3, 0, 18, 31),
(141, '2014-11-30 19:07:05', 28, 1, 4, 5, 0, 3, 0, 0, 0, 25, 31),
(142, '2014-11-30 19:07:08', 28, 1, 4, 7, 0, 8, 0, 1, 0, 18, 31),
(143, '2014-11-30 19:07:11', 28, 1, 4, 4, 0, 6, 0, 1, 0, 18, 30),
(144, '2014-11-30 19:07:14', 28, 1, 4, 0, 0, 8, 0, 0, 0, 23, 29),
(145, '2014-11-30 19:07:17', 28, 1, 4, 6, 0, 5, 0, 3, 0, 17, 29),
(146, '2014-11-30 19:07:20', 28, 1, 4, 6, 0, 6, 0, 3, 0, 17, 29),
(147, '2014-11-30 19:07:23', 28, 1, 4, 6, 0, 3, 0, 1, 0, 17, 28),
(148, '2014-11-30 19:07:26', 28, 1, 4, 3, 0, 1, 0, 0, 0, 22, 28),
(149, '2014-11-30 19:07:29', 28, 1, 4, 1, 0, 8, 0, 1, 0, 16, 27),
(150, '2014-11-30 19:07:32', 28, 1, 4, 6, 0, 5, 0, 0, 0, 21, 26),
(151, '2014-11-30 19:07:35', 28, 1, 4, 0, 0, 3, 0, 0, 0, 22, 27),
(152, '2014-11-30 19:07:38', 28, 1, 4, 3, 0, 4, 0, 4, 0, 16, 26),
(153, '2014-11-30 19:07:41', 28, 1, 4, 3, 0, 1, 0, 4, 0, 15, 26),
(154, '2014-11-30 19:07:44', 28, 1, 4, 4, 0, 3, 0, 2, 0, 15, 25),
(155, '2014-11-30 19:07:47', 28, 1, 4, 2, 0, 7, 0, 2, 0, 15, 24),
(156, '2014-11-30 19:07:50', 28, 1, 4, 0, 0, 1, 0, 1, 0, 15, 25),
(157, '2014-11-30 19:07:53', 28, 1, 4, 1, 0, 6, 0, 3, 0, 15, 24),
(158, '2014-11-30 19:07:56', 28, 1, 4, 5, 0, 1, 0, 0, 0, 19, 24),
(159, '2014-11-30 19:07:59', 28, 1, 4, 8, 0, 4, 0, 4, 0, 14, 23),
(160, '2014-11-30 19:08:02', 28, 1, 4, 7, 0, 4, 0, 3, 0, 13, 22),
(161, '2014-11-30 19:08:05', 28, 1, 4, 0, 0, 7, 0, 1, 0, 20, 33),
(162, '2014-11-30 19:08:08', 28, 1, 4, 8, 0, 4, 0, 4, 0, 19, 32),
(163, '2014-11-30 19:08:11', 28, 1, 4, 8, 0, 2, 0, 3, 0, 19, 31),
(164, '2014-11-30 19:08:14', 28, 1, 4, 6, 0, 7, 0, 3, 0, 18, 31),
(165, '2014-11-30 19:08:17', 28, 1, 4, 4, 0, 6, 0, 2, 0, 18, 30),
(166, '2014-11-30 19:08:20', 28, 1, 4, 8, 0, 7, 0, 1, 0, 18, 30),
(167, '2014-11-30 19:08:23', 28, 1, 4, 5, 0, 2, 0, 4, 0, 18, 30),
(168, '2014-11-30 19:08:26', 28, 1, 4, 0, 0, 1, 0, 4, 0, 18, 29),
(169, '2014-11-30 19:08:29', 28, 1, 4, 3, 0, 0, 0, 1, 0, 17, 29),
(170, '2014-11-30 19:08:32', 28, 1, 4, 0, 0, 6, 0, 3, 0, 17, 28),
(171, '2014-11-30 19:08:35', 28, 1, 4, 3, 0, 4, 0, 4, 0, 17, 28),
(172, '2014-11-30 19:08:38', 28, 1, 4, 2, 0, 6, 0, 3, 0, 17, 28),
(173, '2014-11-30 19:08:41', 28, 1, 4, 3, 0, 8, 0, 3, 0, 16, 27),
(174, '2014-11-30 19:08:44', 28, 1, 4, 3, 0, 2, 0, 1, 0, 16, 27);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=263 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `departure_id`, `size`, `destination_id`, `departure_time`, `arrival_time`) VALUES
(86, 1, 17, NULL, 114, NULL, NULL, NULL),
(190, 1, 35, NULL, 117, NULL, NULL, NULL),
(228, 1, 40, NULL, 372, NULL, NULL, NULL),
(234, 1, 3, NULL, 330, NULL, NULL, NULL),
(235, 1, 4, NULL, 420, NULL, NULL, NULL),
(236, 1, 5, NULL, 210, NULL, NULL, NULL),
(237, 1, 10, NULL, 120, NULL, NULL, NULL),
(238, 1, 14, NULL, 150, NULL, NULL, NULL),
(239, 1, 20, NULL, 420, NULL, NULL, NULL),
(240, 1, 22, NULL, 480, NULL, NULL, NULL),
(241, 1, 23, NULL, 480, NULL, NULL, NULL),
(251, 1, 12, NULL, 725, NULL, NULL, NULL),
(252, 1, 31, NULL, 435, NULL, NULL, NULL),
(253, 1, 32, NULL, 319, NULL, NULL, NULL),
(259, 1, 27, NULL, 54, NULL, NULL, NULL),
(260, 1, 9, NULL, 1016, NULL, NULL, NULL),
(261, 1, 26, NULL, 52, NULL, NULL, NULL),
(262, 1, 28, NULL, 1760, NULL, NULL, NULL);

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
('2014-11-30 18:48:15', 4);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `name`, `category`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(1, NULL, 1, 500, 500, 'geznaslexnas', 'star', 'yellowStar', 0, 30, 0, 0, 0),
(2, NULL, 1, 416, 892, 'geznaslexnas Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(3, 1, 1, 780, 662, 'lexsla', 'planet', 'molten', 5, 4, 3, 3, 1),
(4, 1, 1, 627, 377, 'di cebimin', 'planet', 'molten', 5, 9, 4, 4, 1),
(5, 1, 1, 906, 816, 'slatha ', 'planet', 'molten', 5, 4, 3, 2, 1),
(6, NULL, 2, 500, 500, 'theso lex ', 'star', 'blueStar', 0, 14, 0, 0, 0),
(7, NULL, 2, 239, 574, 'theso lex  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(8, NULL, 3, 500, 500, 'ditcebi', 'star', 'yellowStar', 0, 30, 0, 0, 0),
(9, NULL, 3, 154, 465, 'ditcebi Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(10, 1, 3, 342, 247, 'gjffktyy', 'planet', 'desert', 2, 9, 2, 2, 1),
(11, 1, 3, 602, 982, 'min lex', 'planet', 'ice', 1, 6, 0, 0, 5),
(12, 1, 3, 419, 28, 'ber lex', 'planet', 'molten', 5, 6, 1, 7, 0),
(13, 1, 3, 970, 148, 'nasqua vetvet ', 'planet', 'ice', 1, 4, 0, 0, 3),
(14, 1, 3, 168, 299, 'vetmintha', 'planet', 'terran', 3, 6, 1, 2, 1),
(15, NULL, 4, 500, 500, 'di qua', 'star', 'blueStar', 0, 14, 0, 0, 0),
(16, NULL, 4, 343, 377, 'di qua Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(17, 1, 4, 863, 535, 'rore ', 'planet', 'ice', 1, 4, 1, 1, 2),
(18, NULL, 5, 500, 500, 'stela ', 'star', 'blueStar', 0, 14, 0, 0, 0),
(19, NULL, 5, 926, 981, 'stela  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(20, 1, 5, 977, 457, 'rise ', 'planet', 'molten', 5, 4, 1, 4, 0),
(21, 1, 5, 133, 324, 'stecebidit nas', 'planet', 'ice', 1, 4, 0, 0, 5),
(22, 1, 5, 29, 80, 'tellex', 'planet', 'volcanic', 6, 4, 1, 4, 1),
(23, 1, 5, 388, 709, 'ra telqua ', 'planet', 'volcanic', 6, 4, 2, 4, 1),
(24, NULL, 6, 500, 500, 'the ber ', 'star', 'blueStar', 0, 14, 0, 0, 0),
(25, NULL, 6, 876, 549, 'the ber  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(26, 1, 6, 493, 763, 'tel di ', 'planet', 'ice', 1, 6, 0, 1, 2),
(27, 1, 6, 891, 370, 'vet cebinet ', 'planet', 'ice', 1, 4, 0, 1, 2),
(28, 1, 6, 693, 180, 'ratel dit slala', 'planet', 'volcanic', 6, 4, 1, 20, 1),
(29, NULL, 7, 500, 500, 'nettelsla', 'star', 'blueStar', 0, 14, 0, 0, 0),
(30, NULL, 7, 918, 273, 'nettelsla Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(31, 1, 7, 368, 940, 'se min gez tha ', 'planet', 'terran', 3, 14, 1, 6, 0),
(32, 1, 7, 722, 17, 'sla ri', 'planet', 'molten', 5, 4, 3, 3, 0),
(33, NULL, 8, 500, 500, 'ricebi', 'star', 'redDwarf', 0, 9, 0, 0, 0),
(34, NULL, 8, 980, 50, 'ricebi Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(35, 1, 8, 409, 59, 'rostegez radiso ', 'planet', 'terran', 3, 6, 1, 1, 4),
(36, NULL, 9, 500, 500, 'telthatha', 'star', 'redDwarf', 0, 9, 0, 0, 0),
(37, NULL, 9, 579, 144, 'telthatha Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(38, NULL, 10, 500, 500, 'slala ', 'star', 'redDwarf', 0, 4, 0, 0, 0),
(39, NULL, 10, 410, 392, 'slala  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(40, 1, 10, 295, 174, 'mingezdi', 'planet', 'volcanic', 6, 4, 3, 3, 7),
(41, NULL, 11, 500, 500, 'ri rise ', 'star', 'redDwarf', 0, 4, 0, 0, 0),
(42, NULL, 11, 913, 608, 'ri rise  Wormhole', 'special', 'wormhole', 0, 20, 0, 0, 0),
(43, 1, 11, 989, 301, 'rire cebi', 'planet', 'ice', 1, 4, 0, 0, 3);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `name`, `size`, `type`) VALUES
(1, 1, 1, 513, 'geznaslexnas', 30, 'yellowStar'),
(2, 1, 181, 195, 'theso lex ', 14, 'blueStar'),
(3, 1, 337, 801, 'ditcebi', 30, 'yellowStar'),
(4, 1, 194, 327, 'di qua', 14, 'blueStar'),
(5, 1, 119, 568, 'stela ', 14, 'blueStar'),
(6, 1, 545, 9, 'the ber ', 14, 'blueStar'),
(7, 1, 892, 238, 'nettelsla', 14, 'blueStar'),
(8, 1, 776, 961, 'ricebi', 9, 'redDwarf'),
(9, 1, 764, 268, 'telthatha', 9, 'redDwarf'),
(10, 1, 108, 34, 'slala ', 4, 'redDwarf'),
(11, 1, 519, 826, 'ri rise ', 4, 'redDwarf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `email`, `salt`, `password`, `resources`, `knowledge`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(1, 3, 1, 'admin', '4lqJghfb5sFBZlnhQ6uvgBV6R5jrkb.RibDVOU7C', '2fe2c5df10044969c2131a8c1bcb95f7b1c391f5a19ce3e3aeedd035c8d9fe5836ec8d48f3fa946d5090c22275d66935', 414, 849, 8, 9, 4),
(2, 3, 0, 'test', 'BF./28f5K2pmepG30jyzyZoiFKQiwQMyoHYUEVfU', 'f8c792e3892eeb94b32fa945a36870ee3a51fe35ad1b1845a1dbe8bf19968b558ad1d86e31e0e2c693ef9e6746997474', 260, 35, 0, 0, 0),
(3, 3, 0, '', 'JLfhi.Al82zdlC.5Ur6Id5VVoSZmozU7ldFTcd6h', '15ad27e1210e28c9fd5eb7248c156e05311b64bf58e7e2062735122bcdb30c9d0d39bebc0c820a20f87ca3c92ec9f317', 248, 33, 0, 0, 0),
(4, 3, 0, 'rtjtrtjr@rreh.com', 'UisavZ.ZyRM2DrS64ZiTd3NdGiseiceywVn9V.L6', '7377962477cd150da3090d4c848bd459114142d90cbc6c4858376107730bb7508b926332bf7d5be2caec5e194cb5155e', 476, 71, 0, 0, 0);

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
(3, 'flhm2OCG1SpFUNciToUC7Xb.OcQd7F80jdkAAy93', 1),
(4, 'aGWADI1pLaDAvjxs7xGgmlhkjqA5URchwQEGBoj3', 1);

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
