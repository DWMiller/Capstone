-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 12, 2014 at 11:28 AM
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
(18, 'Ip0XUV9bSyW/eNl/05PszNchETufCd/gIz3ut4gb', '2014-10-15 03:34:18'),
(18, '4bzue5PYq3tUP6EUxx756//MN5hnTc6vQZ0B8Tle', '2014-10-15 03:35:44'),
(24, 'Ah0b1EDS2VxJ8ZGJGx3MsySfnPy0RMgRcs0xwJAq', '2014-10-25 03:02:36'),
(24, 'yj5XqanFsFM06ebcKU3NMyFBV4rYdgGxuGXBm.H6', '2014-10-25 22:37:05'),
(24, '8pdIAXhZM83VasXmfZT1GGCke.RBC7t4YfnMZ8Uy', '2014-10-25 22:49:32'),
(24, '7grZ6chCHgYtKTN6LkgBIRL4GZodhcrjz36ssdUq', '2014-10-25 23:22:39'),
(24, 'DCwCgaMPSPmhFcLyLrLOHwD/Yv/RuFJ8FPUKVkQ2', '2014-10-25 23:24:34'),
(24, 'xGyWcIV1mXhzA4Asj.00H/YYx4sJKxv6sLnhDGF9', '2014-10-25 23:24:49'),
(24, '4wrLIICy1hoNDbNv4zXWDdCas8VMouWaaePruTgE', '2014-10-25 23:26:11'),
(24, 'x7mSHcn5UKIx02x/cVCKoredn9jfDq5VWvy2Ygjb', '2014-10-25 23:26:46'),
(18, 'lfTxzA77ipaF2qhvp/35mPkTX/4laP1Q.zN2TYJe', '2014-10-25 23:27:49'),
(18, 'P61hqQON97CJN8CnOGz48gQ9FS6P6xJYU39gy8MZ', '2014-10-25 23:28:04'),
(18, '7y/THsq1Ij/hUDKma/Xd07x7.7mKg.aLZ3y/NDTF', '2014-10-25 23:28:51'),
(24, 'Zpsrk6tf298IIRa2gF4IX9jLNi0hX/oQIkcDfgDa', '2014-10-25 23:29:06'),
(18, 'Hu59ZZEhl25Z3KxpO3S3Rzq4S.IZQXLxGWgTAGIR', '2014-10-25 23:29:23'),
(24, 'Bzt14i8keC9LkRcz7xeJvalUjq9akDdZ9xnto2FS', '2014-10-25 23:32:24'),
(24, 'FFccKcKXSvQpppid5iqjgEOus56evh8zeob39t.f', '2014-10-25 23:33:22'),
(24, 'diw7nT07O8Qo8sqCVwuMigKHPk6JXgWIKDmQHJFB', '2014-10-25 23:34:09'),
(24, 'pQIO2h9iiO1Sz/5t9vXurocFEQMuvPxRxZsqOO9W', '2014-10-25 23:35:53'),
(24, 'Hq8Vw49ib375AxrIDuUZt7YAgnRFFFlIsC41HOc8', '2014-10-25 23:38:58'),
(24, '2QxngGUnOBV0UZGncX/80f7UnlUjgT6Au1FQiyuw', '2014-10-25 23:39:16'),
(24, '.7T54nJQ4IvehzaeL739UM7Nar9nngd7hcBgKItp', '2014-10-25 23:45:23'),
(24, 'cY7E6s4JtlsCUgzxQnch.Vk1TudaBpShFlXL33yq', '2014-10-25 23:45:43'),
(24, 'OSkareK43H3jmDA7AE30tV2KbMvAmN6ITgpB928c', '2014-10-25 23:46:38'),
(24, 'lW2a0koKepejwyKeeTlGf177cDGiYMcqSvQ/ziJk', '2014-10-25 23:47:52'),
(24, 'FC4tIOCnAVYrkmqHnPUZvU/xi5Rv0n96uoYZG37D', '2014-10-25 23:48:15'),
(24, 'VA1K4vYU6wT18EmuCrF3qMLyoP.unBrIaBYH8Ay0', '2014-10-26 00:15:02'),
(18, 'ljjolFeYOwt5yXwKhOkRizZMsIDERZGqc3TJFUL5', '2014-10-26 00:19:10'),
(18, 'ouqfIZoi5iJX6CNg/rolUkIHq3rQiNZMkWaC1p..', '2014-10-26 00:24:34'),
(18, 'N5bYCYOCbGkbC7EAsgl5xDAyafcTxE4a3ELRznSb', '2014-10-26 00:27:24'),
(24, 'kav2jom42iuLqppaPslxNCjW3mtpVUQPHrLFiiKU', '2014-10-26 00:49:19'),
(24, '75yyRl6QRj1poo7xLPWdZlB7R7kEgJA/3ACVGnEe', '2014-10-26 00:49:49'),
(24, 'CzAnt1UsFASMN6EdR5WDZh82deW7AJGs018wc2kH', '2014-10-26 02:40:06'),
(24, 'b64U9ePgTV/cklhWmlN9Qr2eKPRXPZaMD1QDJBCj', '2014-10-26 03:33:58'),
(24, '/digeAd.//ny8XHEHRv6B/WUH30GvBaPGdIaxFT.', '2014-10-26 03:37:26'),
(24, '6N7/xwN.sL./uFCe5uxzrxEiBdQqPJZHhS97Jw2G', '2014-10-26 03:44:54'),
(24, 'O8VkLmXhdsFyZbF6Q3JelEMNTV352RH/82ldUwmL', '2014-10-26 03:46:20'),
(24, 'TrkY1dmFr2WEe0j3vjKwmW4ajmmSzqa32vuf.LGf', '2014-10-26 03:46:33'),
(24, 'qGPIYt2rfUPA4wqbAdIKinyXRTMXakJS64oJPfx9', '2014-10-26 03:46:46'),
(24, 'B2ICI..3isOA921I4IaWfrGN4Q7ThpBYKtXdBxqe', '2014-10-26 03:47:28'),
(24, '8ftTY0064CEDV4PKRCIuX0wiYSLE2QosCjzuXDrf', '2014-10-26 03:50:56'),
(24, 'vujFoxeDENp3L0E2EZoiKklvmn4NnRqALBLpIQaL', '2014-10-26 03:53:01'),
(24, 'TChfjC4RUFK/jxI3bWTTc6RXRa7QwcXxHADwqUDo', '2014-10-26 03:53:06'),
(24, 'e75PdcCwuGrNSEnPld.ZlT/HlcjL4XAuMSrsJaxp', '2014-10-26 03:54:51'),
(24, 'Jb00Nn/LRThpELSTkgi75w2ogRGCO3XExj0NHKz1', '2014-10-26 03:55:10'),
(24, '77ELNOwYGKTT0xqKf1vcnRHSsCqmeCglWd5Jw9jd', '2014-10-26 03:56:51'),
(24, 'agNiO6bU9yUFD1CXIAaRO.JluHc7LNX4TLnfeGN4', '2014-10-26 03:59:37'),
(24, 'hibcxlkK4BwTJjCGcWYHwqYgPK0R1XDO4F/RCcHn', '2014-10-26 04:19:37'),
(24, 'rt.Y/krOwzFvH88Rc2h6amw8VWt0y4dZd4LPa.Sa', '2014-10-26 04:22:16'),
(24, '7shuKdulWQLznv6QhyimsQiMob3EOcaiFPcDjOLl', '2014-10-26 04:23:38'),
(24, 'suz8BG13dszK/JhkF.Lw0Mf36fSwvZXdberwVSpE', '2014-10-26 04:30:55'),
(18, 'mw41zEf8yO9wLmWv4dx7e0Jxr32kVSqZZrNT1yrt', '2014-10-26 05:06:42'),
(18, 'nx9uzMki8lziOFQosjNG0f9F3MrH.G6Koj.oux04', '2014-10-26 05:07:10'),
(18, 'U8PGeNYZyfvyq8A61vqzCgQOb9QOpR7n3.oiQ//p', '2014-10-26 05:07:46'),
(18, 'SlNztoK5l.gZy0E2HYz9uVhBgp53uEKKyy3JUwxi', '2014-10-26 05:49:18'),
(18, 'h6kH8WxIBGkYmWa6O9KVJUkuMOzg62cB3RSBEfws', '2014-10-26 05:50:29'),
(18, 'M6gwl3lKJ/CGn0Na6udM0p/.Hnz7ULxddHiKl9vl', '2014-10-26 05:54:36'),
(24, 'fP8GCQc25/OWc2es7STSPVftS2IYKoVHC94UfGy7', '2014-10-26 06:07:06'),
(24, 'x0fDmWkf1PcdtT4Vqhq2XyDfIzXZEJ/Ru9KRy1jh', '2014-10-26 17:56:12'),
(24, 'R7h8bh8b4Qqlm1wh8Pqo9sqCGg91UaDx24yunU33', '2014-10-26 17:56:43'),
(24, 'Pzs4dupMA1Kru1.HG8wPIAVJnOggbCWpQaDet.IB', '2014-10-26 18:01:06'),
(24, 'NtEoSzcvaXhFu/qh6lSXrEPWVZaBn/1/EqkRll2g', '2014-10-26 18:02:05'),
(24, 'RqUzxE8hwkzt8.Vg.9Kt7xyENnJ6SU2/k8WA1xDX', '2014-10-26 18:04:49'),
(24, 'qNHk0L9jKiOhGKIPitJlCWnd1kaCuYBoh4C6JCqI', '2014-10-26 18:09:33'),
(24, 'wX/oEx1JnTNt5xWhmsG3y6HGpwa3sq.V2sbyUEWT', '2014-10-27 06:18:34'),
(24, 'dpADPPgn/x7kqNqEoWSRGqovtjykgQFbPMtzlTHK', '2014-11-03 09:35:39'),
(24, 'LMz1aNHNsYM6HoE3eIDT72KaWNg.TA7xIIG0OLNS', '2014-11-05 07:16:09'),
(24, 'fO5LNsl4IFryWvyZbJpY9Tq8qwhdfb9obBwGyuZU', '2014-11-05 07:30:37'),
(24, 'H392z7bfGr3bSkNsOocck4EcFZBomquvhrHCQIAl', '2014-11-05 07:31:29'),
(24, 'idO.mJEdcwIPvXbL8FvdtyN2MPQzQrEi7QVwyOn.', '2014-11-05 07:45:24'),
(24, 'l88FplbxYST8XIuyKZqRhxUQptRwet/gMW3kgRcC', '2014-11-05 07:46:08'),
(24, 'yZn/cgvhRu6rGfcgMQYqAdFEUKSsY1QIlYJN7aF5', '2014-11-05 07:46:35'),
(24, 'kygxnr1guAyEVDygkAutDIQ1fgXnoPuCTywKp15A', '2014-11-05 07:47:30'),
(24, 'mWngaCAxeZHU0wIgI5X8EvuPbWjJCstFTsgDUFgk', '2014-11-05 07:53:15'),
(24, 'Phy9pwwZV2u32/wGC73Zi3gWhq/cY70NJIoU37IO', '2014-11-05 07:55:57'),
(24, 'Ir5ASnPqNh1Xkr3u7FN/xADY2cJqpB7x1WHchL/T', '2014-11-05 07:57:13'),
(24, '4Q8Mplm0aDUgH1FUgYq5k9VVkf46auyEofH/CoL3', '2014-11-05 07:58:03'),
(24, '0jeUjJQlaX2CvR.nKP/3mVSZBwKGnr4X0p4btuRq', '2014-11-05 07:59:06'),
(24, 'istNkaEP9cOAS/vSbLwXh2b94Oywk1M.eu.XVViH', '2014-11-05 07:59:59'),
(24, 'b3ELKrR6E3bYppNffHnQcgUIWQO7W6ZaM/9WnrUX', '2014-11-05 08:00:31'),
(24, 'WiKdQ4acF3h42DOR1ktgZo2s0T/jpgmHsT/sBTEc', '2014-11-05 08:01:12'),
(24, 'rDDBg5zP6VaqATWmg3CdTKD360zQTNAbiHJNKHMd', '2014-11-05 08:03:04'),
(24, 'Kt1hIDrNarDcPiy9oIEYa/o1wPfO1d./bJ2ZZHNM', '2014-11-05 08:03:22'),
(24, '.vlj9hhozkhJuP8ES5R5OjuvPgwvZPi9A60ycZQB', '2014-11-05 08:05:18'),
(24, '.NlgXvzEtlJzmEyJHVmXOmrQnjUYImWzDatTit5j', '2014-11-05 08:10:30'),
(24, 'jqBslsN8ekogXReOil5YLoZ/t8UhnfDWYEXBrZhy', '2014-11-05 08:10:57'),
(24, 'faR/MdFoQlmCGhcVbEbDKG4bmSZLZ6SW6ok8fs4.', '2014-11-05 08:14:10'),
(24, 'UxPGhiQ6pcxv57pTQom3wChasAPBtDF26DTlUJeP', '2014-11-05 08:14:50'),
(24, 'aHgKZbehymFmyu1qhYOlvh7OghpndHjvXjJZcfEY', '2014-11-05 08:15:05'),
(24, '60LlGeUR/S0q240cuu2tS2qVnKjZAwvgKHyNVu1V', '2014-11-05 08:17:01'),
(24, 'ldtDIuelO5/61Iem.RazSNV7z54.UvAegbpP2B3X', '2014-11-05 08:17:55'),
(24, '49EbV0HIlYkpAIeeATlHnPTB9tyn7efhIXBIo6Xf', '2014-11-05 08:18:19'),
(24, 'Cn2JX/yNnlXBXuEDxQO44jn0iGdlBG/7tpbATya2', '2014-11-05 08:19:10'),
(24, 'aunBQ5bn1jjA9fZoZM0fSzEt3/adFMdL0aMukPMU', '2014-11-05 08:19:32'),
(24, 'MwJqDwMwrXI339QbyZn5USaRKSXVfavvSP/3zPej', '2014-11-05 08:20:14'),
(24, '3kbO4vt7jvzXyxFoUoj5/JJfZEtoguznJKTpcFFF', '2014-11-05 08:21:45'),
(24, 'zjC/TRATZ/9jvp8hQPRRzvJLhUaIO8FoPPx78eg8', '2014-11-05 08:21:57'),
(24, 'lpIkEkk55TGVkcF4vVUhc6c3ZdZSC8pJ1urA8QMo', '2014-11-05 08:22:16'),
(24, '64W4lSlBguqbi123EHsNWfHTrZrMAF4mcsJRFOQI', '2014-11-05 08:23:09'),
(24, '7XOku7AbU51CoB/hceczOQnh//.RjwDnya6FOEJE', '2014-11-05 08:24:09'),
(24, '.9dCwrL4OwqcAP4HJ9s0E/P7ODWtQrpQDqQrE7B7', '2014-11-05 08:26:08'),
(24, '//VK0rqh1HKWnyCPKOCK1pS4JvpZ/Xf/28G8fzzu', '2014-11-05 08:27:16'),
(24, 'RCRSRWsV5QXGcBKtDXheRQCR5Ou/LvBfk3HhMOvR', '2014-11-05 08:28:37'),
(24, 'rTnOeMmP7Rs8jx2HOirZUWQRmGhWyyeMbxvb3PcF', '2014-11-05 08:30:21'),
(24, 'Ubr76gd.Rynu7lM2HYF89DfrpLi4qQtIx7HkBEjl', '2014-11-05 08:30:48'),
(24, 'klqFs54qca/IEDr3xUbWFV4HtVwbbHWqyloqfgXa', '2014-11-05 08:31:21'),
(24, 'KEGHuTKbk6KXb1fo1l.h1..LVNlwtRDJ.XFpe8.J', '2014-11-05 08:34:54'),
(24, 'dF437cpPrf2yD5uyR2UL2CmSCOiWB8fJezYB7mRJ', '2014-11-05 08:35:33'),
(24, 'yNV0Qa5tMDsDmJa9ViG8YwqbdogZNWcU7WNFRquz', '2014-11-05 08:39:49'),
(24, 'jZ0IUwDdHdYVeR/JlrAp6YPcQ.P5x4i2qR.aFYqM', '2014-11-05 08:42:10'),
(24, 'iByaOSotG/4XHgE9wDj2Hx5.edkV3dcu6GKNzSe8', '2014-11-05 08:44:44'),
(18, 'KNh22oh5itRzNz2Brk0o.4jXG9G54brlsRvOFf/r', '2014-11-05 08:46:37'),
(24, '0q4mo2mgnY3kRy8Bbtr7iXOBnzdrAkvRgHF3nR30', '2014-11-05 08:48:56'),
(24, '4Ql6yRJEasZU4QY1qy5v23fm/6om8FNkLxbyUTz9', '2014-11-05 08:49:29'),
(24, 'qPey9KMdViLfnfo9imz1J4KcRXdJ7vgmcKbIUMPc', '2014-11-05 08:50:12'),
(24, 'rnhOwm0LrV/80hOujAI3xVX3ngFhRB1vafJd5gd7', '2014-11-05 08:53:07'),
(24, 'AD23949I07C8Sc0mlekRjuQsj69qhVHcXDm48RCF', '2014-11-05 08:58:14'),
(24, 'X7OsFQS.46Wy0dIpQkPpZApcdX9swumzxGrdJ.T5', '2014-11-08 21:38:10'),
(18, '6vMGbl.JDgOEoklLMYcqr87NA18onKPC3PuESuFo', '2014-11-08 22:48:14'),
(18, 'nIOCB1R772iJK8fZflVLLXuvQI7uvqh4lvfsOH2P', '2014-11-08 23:32:59'),
(24, 'OwU6i3/hED62XtdQ1RpDYz5PaubNlrvV0SvPY.M8', '2014-11-08 23:50:23'),
(24, 'AT5hGPTi42OSW5HSVRdyp7mEY6TjdNra4.1LIZCn', '2014-11-08 23:52:22'),
(24, '70fCaFxJI2vY2h3QdaWJVvEl0HHd.hb7O0Cx/hbE', '2014-11-08 23:53:31'),
(24, 'imV3wLkwM.4QNxcoxaNf2jLztPGWD2kUzNxZkCPD', '2014-11-08 23:54:30'),
(24, '14JzQy8Ad4L7CZiTiR80pClmoiLxqCqqM49EfKZj', '2014-11-08 23:55:24'),
(24, 'aotaesU2ELtz75XY6oRdU2VX633Hri.Z3lSwdiEK', '2014-11-08 23:58:57'),
(18, 'CrvVA4Xil1lnT4oF50opbUCcxwU6EjZt5VYtgbHg', '2014-11-09 00:03:55'),
(30, '2L1yQvMwAwSulMwq5LDbjmscerkOEweRZGLqtsYb', '2014-11-09 00:38:15'),
(18, 'eLrVv.sJC0CyUjtUImGErJN9weOAJ7mPAxmFv4Tp', '2014-11-09 00:38:26'),
(18, 'wQ78qnSu.Y7GinOsbeHc.xeftPOf2tdf815HEeMf', '2014-11-09 00:45:10'),
(24, 'SID3ROaVX3ycEfMfFwejKJ6FRsO9TdY2dXKQwi0W', '2014-11-09 01:00:40'),
(24, 'vOloDoLa8c3jmeuaReNYuxHkE7kF1TMmReY0bs56', '2014-11-09 01:04:42'),
(24, 'fmIA9yZY6BGdlAGAce3ANUrfbjxArvl0tVCMxTv5', '2014-11-09 01:06:05'),
(24, '9Z0ivLp..EB.28du3hN8PF8ALNCJw906xexK9IHh', '2014-11-09 01:08:45'),
(24, 'z61Sr8yszTVnRFokuzX.p3AD.lTqD8N.eqtM45nW', '2014-11-09 01:08:54'),
(24, 'g0Spxuvs/ubr4vmIJ8TGkMdw0qIZtJEj0TDy8WfI', '2014-11-09 01:09:41'),
(24, '.Vde9j/LNaBI36iSaelvd6q0.l9vCID4doiPidwV', '2014-11-09 01:11:55'),
(24, 'bfP2tl8pbo8eQwNtTES1iNX8UMM5ycIGGcZ8sTDW', '2014-11-09 01:12:02'),
(24, 'V/KFtGqLsOgaueVuiIOJRwSijTt1tJOBF/kpsS.r', '2014-11-09 01:12:21'),
(24, '9MqsEPd8qqNrOx.5xCvFuhiY06ECJZf8W2Pm23G2', '2014-11-09 01:13:31'),
(24, 'wI96WkjbwzRAfc4DWgSKlzvuhZtdMi/a1wlnK0xE', '2014-11-09 01:13:45'),
(24, 'flgwf0HNN1KCtxEAcJj0w0mTcUOnMPSTainYZMfG', '2014-11-09 01:16:05'),
(24, '//THKnNGMPl23PSYAMVzDAs1NGES.HEwZe9ejGkc', '2014-11-09 01:18:19'),
(24, '3GA.A1Cs.bVaGD4jFzqAAF7uR4mo2l3YaChN7fwY', '2014-11-09 01:19:53'),
(24, 'eqKpMtoNbyjtfLbFgmQwpe0mQfqQo/rzdlaHWFDV', '2014-11-09 01:20:28'),
(24, '3wcuO374XQfpNWDYg4vf0Jg2nrO6B40kjgGLNHtf', '2014-11-09 01:22:23'),
(24, 'GKKHUB7ga9551RNuO44XFnz3dCrT5YK304KdNYyS', '2014-11-09 01:23:05'),
(24, 'm5k0DX.Qxg/6/Uf2oLPVuuCxP2yhOVxt/epI4ZmJ', '2014-11-09 01:23:46'),
(24, 'PRjsrz2nJXbiisiXE1/tmX3pSG/gKu4JnPWGvjXV', '2014-11-09 01:27:05'),
(24, '/HNvcma59Hgt1kTYvXVg34xZTrMahOdJiIgTXKPX', '2014-11-09 01:31:25'),
(24, '.uxfdKcZSLL/8hhvArj2RqpoHtUEYmGPOgA4d3K0', '2014-11-09 01:32:12'),
(24, 'xe4pkrr.cETwIC9WjXcudjmVwckLYHW40OzZBM0B', '2014-11-09 01:41:37'),
(24, 'YhG/dp6jAaCGLkTk0as/7LIf2EUUcA1x6ogyQaui', '2014-11-09 01:46:22'),
(24, 'leszADm3h60tx0BO6rPFGKvKo7.qvCzmDEqZ/6J5', '2014-11-09 01:46:32'),
(24, 'CqxFByHy5VJtWzpuyuCRLlDc4ocQgirT3YDkk8ZS', '2014-11-09 01:46:49'),
(24, 'o0puBNbfjKwkPOc6YfJLfIX5shoHU3okjXKcm3bB', '2014-11-09 01:47:33'),
(24, 'BcolRKYCUtx1khT0vMF7I43viLYoVX23DhZgbK81', '2014-11-09 01:47:50'),
(24, 'K6TX4YuS6YW9o/l0GyW2BMpfJSUZJfTHNWZspoIB', '2014-11-09 01:48:56'),
(24, 'noGTQ/622e6XwoOsW321BRNN49I0dx9HiPkIgSSi', '2014-11-09 01:49:29'),
(18, 'x8Cdnek6kKmqjrvBMytfXK4apTsQubDH4.XIZKtf', '2014-11-09 01:53:15'),
(24, 'DzLDtB5BORvqPZBmlIlGmeEd7l19ufQgxMfLBFAk', '2014-11-09 02:00:54'),
(24, '4muucdXAq6nX1ZwOnGVdaTK6pw8TmSxjiwjr3A5t', '2014-11-09 02:04:03'),
(24, 'ML0eKKcJ56hvvPzSi613CaOPVVjrJDvIngm1OaHs', '2014-11-09 02:06:04'),
(24, 'Lb4BEKvFOezSna1G2Hq4dT5ux33P42tQTPmlXNUX', '2014-11-09 02:06:44'),
(18, 'X.kCXcYQN.bOEg3ae8DeTJdlD6za8j0443cn8niE', '2014-11-09 02:07:14'),
(24, 'JLlHDbxXa8ThGHPrFSeGbpDTOHsso8EyNWnubuSr', '2014-11-09 02:07:34'),
(24, 'gguTKuvS5SKVimmdpZ0BEWg3boo737bGM/fAQDuI', '2014-11-09 02:08:01'),
(18, 'eMQOK9smkXvWBbmjK7hO7JYpXnEoxv98d5nWK3y1', '2014-11-09 02:08:19'),
(18, 'cTlqP72ubuPlNSKM0rGUYVY.p1/cOC5VWbg6PpTw', '2014-11-09 02:12:58'),
(24, 'qHJDyycrG2tnjIwKyYxG/YV4qY6FzSecO60Aqrge', '2014-11-09 02:25:00'),
(24, 'DoAooa/SxngTG.rxOMTDXDDSg0jzxhwNcWmhHF/y', '2014-11-09 03:39:46'),
(24, 'HpngmSnqelzaeKn7wJx66rdjflFs6xO8lC6gV6P.', '2014-11-09 23:15:29'),
(24, 'QMQxmaqBIqnYcT6LjxtjwACI9krY9BCsRMvuXQzq', '2014-11-09 23:26:16'),
(24, 'WnsIspW7OqfhMVtzE4hWQ5Wdn0smKl/XD53JIJrZ', '2014-11-09 23:28:58'),
(24, '.qUQctyLTUj9gNIfmkboO8AtCbmdt6U8EEeJY7vl', '2014-11-09 23:29:12'),
(24, 'qSDeZG5RwPLMHCFLzY.4oJvJ3nwSqm9LmA8FnLCj', '2014-11-09 23:29:19'),
(24, 'T1LoNp83g5LKFIqgLxxQs6DZoDK.BRg0VjzK3GJ7', '2014-11-09 23:31:00'),
(18, 'cdeFHPx0pEcdItMwaHyFutsxDJRU0x0wB5K84ffc', '2014-11-09 23:32:29'),
(31, 'yuPvdB.LHI0WZGG5Z5QOTgyvv4mWne/qTDIlyIwn', '2014-11-09 23:35:49'),
(31, 'ffgaAP6uwoqpL3pZ2sYsDVLBOLvO6G7HXadv6yus', '2014-11-09 23:38:30'),
(31, 'QjabolEP6wh8vgBxNYyoMMMW3xr4BT9KsTk8Lry2', '2014-11-09 23:39:34'),
(24, 'qQnwzwclktkOtG0hWlGFRdT1U5/hR5mvfLpDZ3Ps', '2014-11-09 23:41:47'),
(24, 'KgQIm0O03XViFZh9AXXiamM8eXQQiypJXYuipMZm', '2014-11-09 23:42:49'),
(24, 'tmVcd8HOjkNsHCduy2RYOGu9/LzI0GaA9zWBbwT7', '2014-11-09 23:42:54'),
(24, 'oclzfvZ49dartmN/hGGza8VrTF/u.d8.1kFE8mWl', '2014-11-09 23:43:46'),
(24, 'bV2xQDpIJjweNt4RTOD2C1LWNVtdddxlPVaVytQD', '2014-11-09 23:45:35'),
(24, 't0dtB4/vW8nxyZweMxj/vwK/2YJZNzb7r9m/apD/', '2014-11-09 23:47:02'),
(24, 'SZjQz3T3FiDDOAMCZcM4yVa3Y58OFHBJaIF5K.gF', '2014-11-09 23:47:22'),
(24, 'B4KAzqTMSP9EFA0uASHRJsW7FK5s5iSUYyZ2bJNv', '2014-11-09 23:53:43'),
(24, '1bovbA7bxSnUobYTQD932qthMlRmSR23ySPFTJXC', '2014-11-10 00:01:45'),
(24, 'B5CNQ52qOiYzZtei1HDnohPom2ElgXfEHhSwk9pa', '2014-11-10 00:07:07'),
(24, 'KZVgjH073RQ7H5PyGmnO5KfEm7h6clEeyegLRRHW', '2014-11-10 00:11:58'),
(24, 'Hz7tMXhTOmp4ycc0qPmAiJbm94L0wYubXYp8MDE2', '2014-11-10 00:16:34'),
(24, '9ACHal0ah4Huf1.GZivyncGY10JajW/GAr1Hp5Dr', '2014-11-10 00:17:50'),
(24, 'YVt/JboFO3/7fJ9klWJ2KVMWX8zjrEcZ1Y6tt.3W', '2014-11-10 00:22:07'),
(24, 'ajzti72Imvh1GX.K.rXx1ICFjHpiRVIKJrtHAGc5', '2014-11-10 00:22:18'),
(24, 'txvS4LijtMBI3cDK74pBDMZqLmSOFCS6MwyXsC7L', '2014-11-10 00:23:08'),
(24, 'YHzcCQLgnsv15PCNBPLtL/w8J35CSLCnjntUwBsB', '2014-11-10 00:25:54'),
(24, 'mikVkt0VHEQt71UAxcVLzZx9LHXYsRrX1tZlksYj', '2014-11-10 00:32:06'),
(24, 'vvbjLUvGPwbKehHSq3l5jwju8aFSpkRQ0pbzqPvk', '2014-11-10 00:35:50'),
(24, 'yc8Dgdn7qq/J4R5iGcjLmcNf01WOE7mSGHkEp5Z1', '2014-11-10 00:36:42'),
(24, 'HFRrkEsv8hznJ6oEH91ctT.HNtJDtJ7tQmLh.2ji', '2014-11-10 00:37:15'),
(24, '5J.K3loGpTyBKo7lWZZgrB0p3IJAIfk.TkIvg21K', '2014-11-10 00:37:37'),
(24, '.6UicGsAGv4S3qqn0KVgu.m5y6bSEOBO.nF1VJyl', '2014-11-10 00:37:57'),
(24, 'qqc0n5SI8.aONDbblYT9QIJlVZ7busChQs82Aw6a', '2014-11-10 00:38:54'),
(24, 'O.63FJtDhU83oXFEZ9vK9vgFt4y7AM1jUuFj/QMg', '2014-11-10 00:41:09'),
(24, 'lfd0wKf7w2N6VgjuUxk3Mk/QLvv6amOZ0hGyx1lu', '2014-11-10 00:42:06'),
(24, 'k30lYbzIG5H4gQXrSwbb95ERL5.gyujje/6Hp0ue', '2014-11-10 00:44:30'),
(24, 'uAWodqn.gVqedhbJQcbWxp6j/NxPuCuoku8mEMu4', '2014-11-10 00:47:09'),
(24, 'tQ8TtpG7G4wb8c7pAsU21vVuojCx7cEAqZv7eLlo', '2014-11-10 00:49:11'),
(24, 'nqfP4EkVGZ5j/P2/2kLHiw2STCYDq0.gXBE4CGXK', '2014-11-10 00:50:20'),
(24, 'wmmBFo1ijgbALkBssNl0UB9gmiTVrSTmj7lJwfmI', '2014-11-10 00:51:31'),
(24, 'P9GjCCH3Rzll7AGFSvxLw/d39Klda.6JB.uKp5zB', '2014-11-10 00:51:48'),
(24, 'ZVVdvYY48hrrMuDdvz2.kw.aXt4xtPzpm2Wy08zW', '2014-11-10 00:53:56'),
(24, 'j2Gt0mY8mJJp7Y1eJKEA01XW57yi4nW0SLyypZiP', '2014-11-10 01:25:35'),
(24, '2IJCYXV6HFES7zI7xKMPtfxvAAFwwSfW1w8NGr.x', '2014-11-10 01:26:36'),
(24, '1WnIm0HKLoqf6aowk9sRC5KcNY0YAKVDUvUYECeX', '2014-11-10 01:26:47'),
(24, '5surgHilEBmCa.6afv23TJel/ZY7aZESoEOtmCAj', '2014-11-10 01:35:28'),
(18, 'oYJrbZu6CchjFnu4VJla8mqNpOkbsR18jnCxs0pO', '2014-11-10 01:56:32'),
(18, 'z6FN1eRSps/pAX./FpLlOuuXWOzqhHz.jTbrfRG.', '2014-11-10 01:57:24'),
(24, 'nU/9SlT/kYDq29rYo/CnxUmQJlZ/VgaU2LAsUWgQ', '2014-11-10 02:21:15'),
(24, '/2TrU.lGCsiIicXizsg12hXfh7dAyVRBNcpx.VgH', '2014-11-10 02:21:35'),
(24, 'ByX8UD1wzB.6NlAJWtbfYVUJwXmwWWM.JFwL4hrT', '2014-11-10 02:22:46'),
(24, 'Aul2KASo9JZUkgV6PWHTgv8P5SWDTbowri6Aqhm0', '2014-11-10 02:24:15'),
(24, 'm3l4OyCvXnjjlxfEZkkWzvBTA5.AhiAhGPz4xKgQ', '2014-11-10 02:25:52'),
(24, 's9SlgO7pAC9BeNrMKHeywDWXIhiT3zJntl1TuG9H', '2014-11-10 02:29:36'),
(24, 'KpXgroN1o3zdblV8kzLRYrqMkPwW4m01LoTs7asM', '2014-11-10 02:31:00'),
(24, 'zKJY0u3L9n/gkYOWfpwQb88nB2vqRbNzSsTOi9Z4', '2014-11-10 02:33:59'),
(24, 'tdpwZfBEkGvv3GktX9mxFm1qWo/CUrUs65vduyq7', '2014-11-10 02:34:19'),
(24, '17BPV60425IWAGrx5JLe4Hx4hmYJj6WrApabuq7G', '2014-11-10 02:45:08'),
(24, 'wfpETYBzWqGi9R3aeoZXvtLhq5a.nod/OwJsl4x6', '2014-11-10 02:59:31'),
(24, 'CbuWeKMVwTLjiP0cHrHtzO1Hjyq9fWsh8lArOrUo', '2014-11-10 03:08:49'),
(24, '9KxDx04swHdD7B/vcI/ozP6ENfo7QVosSltsRsBf', '2014-11-10 03:14:56'),
(18, 'qBfiW6ECtRNnMzlKYyXVtTuKmZh8SRoWp242z8cg', '2014-11-10 03:26:36'),
(18, 'ZpqbdR7apG3onujI3RzVvHISpA78ffQs03B0W75Z', '2014-11-10 03:30:27'),
(18, 'y.3Aoc55kGRzLqFGfJ4sv4qmj4Wy0lfbpumLTxcR', '2014-11-10 03:31:05'),
(24, 'lk8ToQl4YfMVQo.r6f3z2cGK596zBv.aZO.rkaUa', '2014-11-10 03:37:43'),
(24, 'sJHvPcPNCqbRTJ9UMUBOPSBImKegx2JSxKQzu11E', '2014-11-10 03:39:03'),
(24, 'H/YcCvsJ/DUqhh26yjLymVTk3e9iJVvfSEpgAWj0', '2014-11-10 03:40:25'),
(18, 'Pp.d0ADHDn5DkSRKj7CE6bNjjZHNExbwMOTKQcGJ', '2014-11-10 03:43:53'),
(18, 'u1qrW8A.PFYJLloIwhurHT8zZblN9emEH68xd/T4', '2014-11-10 03:46:52'),
(24, 'Nyg2KCKb8g5qA7JhJrilyyBo2pkG9VkwI8mD81PF', '2014-11-10 03:52:06'),
(18, 'tDB0teRwFHdRZZTLLR7Dhw2srNP0vx0wjTMoq76B', '2014-11-10 03:53:26'),
(18, '4hJ.0dHTM1SvfXz1ct1bp1Kj7i4CjtNTzLGdfo7h', '2014-11-10 03:54:08'),
(24, 'iiLd4FlO3tsL4qnt2cfu/j7dVA3bAuiAvAQGb6D3', '2014-11-10 03:57:10'),
(24, 'a3IGDim/gwaXk7P8RJyABTOBK/3g9axXT3Sdx9.0', '2014-11-10 03:58:49'),
(24, 'KgJunX7yaDqgV2NwVTDkJzrc3kvE0Afx3Ym8IN3U', '2014-11-10 03:59:40'),
(24, 't5/YsyCpgEljf9ZFgYYs7qwpm6wBrGHFJ/XcPoJh', '2014-11-10 03:59:56'),
(24, 'hRjQ11/OWXNiURrRimYSaYHeirHiN629YrJGEADp', '2014-11-10 04:00:34'),
(24, 'socrT8wcTca8nnS1OadxNCLUIgGDwReOT9xiVCM9', '2014-11-10 04:01:54'),
(24, 'wzD5vmLe2dlpvIDSKV/0CKkbnF2HoyWML57JVgoI', '2014-11-10 04:02:33'),
(24, '28wmYBiiP46N0ORENdxOwIUvwW/eucW0kAoJIwd8', '2014-11-10 04:03:45'),
(24, 'VZb2LZMjGLdLaTyG2znBH619hT4VyMKEp/hga4zl', '2014-11-10 04:16:34'),
(24, 'iPLUsyAjy3uJtETmxfwhpyHbeWJ0aMyOpC/FWtRu', '2014-11-10 04:17:15'),
(24, 'pr7f1a2t7/cuuCsjQoEnwzsUaLkpSUOMm86feUBg', '2014-11-10 04:24:27'),
(24, 'QjUimYugmr8sdUzLcMg2xwm/3IeCsMsBRlGGFu0W', '2014-11-10 04:29:03'),
(24, 'lS63pPtxBMPak9an6AQVm0f74oBiAOVn12jrqILL', '2014-11-10 04:32:43'),
(24, '/jO6BIk5pmccp9Wl6YQ9FcaaYIdTHkiwmf.vrF/p', '2014-11-10 04:37:48'),
(24, 'NMxdMeAhKW31dWI4eZPqyRrtBOTaiy.MHbLpeOML', '2014-11-10 04:38:07'),
(24, 'UJc7AXiB4GMdT7uxpO5pG6PipYRK9z5aJGkia3Bf', '2014-11-10 04:39:29'),
(24, 'lJ/XJycj/mxu1doKEmXLmwYYXkhlVBOWXreaKtbq', '2014-11-10 04:40:06'),
(24, 'uVbiLd05X6B9jrkV9qupD5trbuuVS8wpr0Y0DcKa', '2014-11-10 04:41:36'),
(24, 'BBvX5QPz3FxrjYaXK6xB18M3B0tE1J42AWcJDyZX', '2014-11-10 04:42:43'),
(24, 'zm4zihojkIaIEia7TIIaO4pCz4zIGYn/FyKauBuG', '2014-11-10 04:44:19'),
(24, 'Qj6DpC5.w43Irg7I/XYlaRXlqBTG6AqEKNEMqL/X', '2014-11-10 04:47:01'),
(24, 'Q2mFDmMqPScpk7Q2c2yxv0R.TIohScMrZfxRyKjH', '2014-11-10 04:47:47'),
(24, '1EDvEVmAPQdPcb/49fZki.qIfmlcaZB3ogGs85Op', '2014-11-10 04:49:11'),
(24, 'RUpz2wxZRZds.OTlwTJN.DjXenlhmBgBJIpU448k', '2014-11-10 04:49:48'),
(18, 'qY/p/Oj1ZSI1f66PRA0QM4.cw4UCLL9klQzHkN34', '2014-11-10 04:51:16'),
(24, 'WVmlQcIMO6zXS64w.NpIZTjw82DzjvE1Q8U9fFGe', '2014-11-10 05:00:11'),
(24, 'KBB5UulvBaDNnF52B.X2jEV86yn6HgDF8gseq40i', '2014-11-10 05:00:31'),
(24, 'jotWaof9G4x27V.sJjU71R/mfG3VbM7AyelgytEN', '2014-11-10 05:40:20'),
(18, 'UTXeVm0Qidban.EXEIuSimAEC5toQ8O4puKBfr09', '2014-11-10 06:43:29'),
(24, 'tklbxSTBGpV0pGjO7ns6eoa.KsIOMl.kmvS2vV/G', '2014-11-10 06:46:33'),
(24, 'CSXHfMOqP6lMa8vtLoYnHSdzXR5rTlaNfGf5qnjY', '2014-11-10 06:48:22'),
(18, '2vd38FBpLVv4bWCGUedYeppBrtouZUYkBIFfepJT', '2014-11-10 06:51:20'),
(24, '13QT5zR7AB8/3/joMb.6MBZQM5KAfuIdlw/di.0e', '2014-11-10 06:52:42'),
(24, 'WhJj.f8DmFgTvu1fG4RxC94dvOnR3QHWeZ8ljMQM', '2014-11-10 07:01:54'),
(18, 'AyPt5fwZ6Uh5iPNrQi4iLsD1fc.W7BhnT8lRts55', '2014-11-10 07:07:13'),
(24, 'yEgmjKPbUwFwxvxsv1sFftbIdaipBlnFZoyIpXWs', '2014-11-10 07:10:50'),
(18, 'RHdewAYLk2sOHI3I.GgwlvlfA1z9.DN08vtrNCVG', '2014-11-10 07:12:08'),
(24, 'AZ0wMTTJkwT4Qr.vRJ1STzws0.w6CeQR05ZFGkYi', '2014-11-10 07:25:08'),
(24, 'L8N/vyQFJp290x0daXElabd8ojOiQxiQ9MK8IpOt', '2014-11-10 07:26:08'),
(24, 'hKC//8h2Zx8ZEndAel.qXoyft5hu0yaQH4C9VhGr', '2014-11-10 07:26:48'),
(24, '38kz2r8jyWmQT/mCbvWNpMuUx7cZYVX8rGQjrh8l', '2014-11-10 07:29:22'),
(24, 'IKeG5bRb0YNn./g9d9Wv1aKDDqLUSXqfN/kIV.lU', '2014-11-10 07:31:16'),
(24, '38IvyegBXdvwtKvW/B0IUr25wsQhws0CCp/uP5gY', '2014-11-10 07:51:00'),
(24, 'rhFlSl9IjxzNfAsTIwBmeVMI2E.fh2vHzITsggZI', '2014-11-10 07:51:27'),
(24, 'X8RWIXnWcBja8bocCbGwi9ZYvKfsKcCzY2Io098g', '2014-11-10 07:53:32'),
(24, 'VjgE1btuwYSovDGemyRuANRFL8vUwxFjqLpSw8D9', '2014-11-10 07:55:24'),
(24, 'hSbR/95dJA0/W9MfSCgbjG2tnasqJ4d.CtdzfNPC', '2014-11-10 07:56:13'),
(24, 'szuG1w4r0uL2S5yxLx13A.A53bkHduJLkmHcOUwE', '2014-11-10 07:57:40'),
(18, 'zZKY1OdXBmf0b/rCbbjB/JJQGWR3.dpdtLQ2J4gX', '2014-11-10 08:13:16'),
(18, 'JxGhZN5MDyhwi1YDXa8eYEpcaISEHTwGw2u3N59.', '2014-11-10 08:25:00'),
(18, 'haEvLiqWh8yifdp4ZbRMVwRfuPnONki0mUvL5I6w', '2014-11-10 08:26:02'),
(24, 'p5HRH04dkU6zpx6GLjrfU2Hv0AIE2ZRm5LbCqR6M', '2014-11-10 08:28:37'),
(24, 'JlI/X2MBV8VENsAe.us.8cAlhYNVsquOITNFVV9A', '2014-11-10 08:29:35'),
(24, 'KEURKB46HlVQ8X6/H8TNIDfer0elboZ.IcYawpmA', '2014-11-10 08:31:09'),
(24, 'wHwvQ0MhKJD7flUPDzAJZ8IrGLmMsE.h6Z3AgdCq', '2014-11-10 08:34:02'),
(24, 'WKkoYkQ6C2kWENvd8KfN.bOB66i1qyGV/.P08/v6', '2014-11-10 08:34:25'),
(24, 'kAZbQGUkjTSLKnYhu5VBoJ0G.B6HhNHMoc.FUx..', '2014-11-10 08:35:21'),
(24, 'nvpkyKbNPT4acEFQ35IiSBUgkyEknLwMrShphZ61', '2014-11-10 08:37:24'),
(24, '6vY1LupkmRRWMGhiWp5FZy9HGkWtnGkx4eK/NZoc', '2014-11-10 08:39:47'),
(18, 'q7A8L4H1c2Gloy9JorG2Y/qJq1MiedGw1x32zlLn', '2014-11-10 16:51:59'),
(24, 'z.98S9MsLlmvpExaX1T8QL9WC0qAkvp7UzTB/ltS', '2014-11-11 06:54:41'),
(24, 'x1AEm7SICuDfF2GFH8B.BIRjLmcxsMNcmw//bi9i', '2014-11-11 07:13:29'),
(24, 'I5m8LdqQzlg7EFK6/WoZzFu57psGpFBJ34iGEdZC', '2014-11-11 07:13:46'),
(24, 'ASxjVw0oK7HyZFKFYDYFxidcm8SfOob8fYOd1U.d', '2014-11-11 07:14:24'),
(18, 'trhMzpF9PA.ajR.ReoGePu/fIDeT.Pjnd1eiHyWl', '2014-11-11 07:18:04'),
(24, 'PxL36EH8KQAfvdRkHUHFTDzcQPdanXHtMNc.1HZm', '2014-11-11 07:24:30'),
(18, 'WuAaotlAFlZZoMZtb.yBUbB6DopbAeRF1u3WO32h', '2014-11-11 07:25:55'),
(24, '3QU4mB.dHDtLE7LjZIANztjyh6scOGyZewDIwN9g', '2014-11-11 07:38:27'),
(24, 'XpefOOPyyYkD93zv7QZ.DHz4jAuUgrrV8z3JvAGz', '2014-11-11 07:39:30'),
(24, 'aOmDGc319g8KtTgjUQHoOxqpSErrEgesjhGabuYe', '2014-11-11 07:42:46'),
(24, 'ZKuvAMtHF254X99MLYaXXtmGGlpwkBzoORoJK0Hz', '2014-11-11 08:36:20'),
(24, 'Gbwp89lHQefqslxGyVgH7mCnpJwJ8lhZZEj3uI2S', '2014-11-11 08:36:41'),
(24, 'DVX3hlLR5yqIDqGCknO7wLGnrrGqQwUtmXkXsAIh', '2014-11-11 08:38:19'),
(24, 'ng/bJSKLwDKwuQ25Jd7WWPq6HVi5IP7rKNoZIksk', '2014-11-11 08:40:05'),
(24, 'Wd9JfWIzhCMqGLsAHy8g/w/QrrKUQMDqSomt41Wt', '2014-11-11 08:46:05'),
(24, 'xjl3VM057xzMJghdyidiWKqyAWxZ8bHCWgfqD4OC', '2014-11-11 08:47:09'),
(24, '1kuf7KDeTOfJWFijHwHVj8v41Y2WqTR8TQJ.p77s', '2014-11-11 08:49:58'),
(24, 'K2ENhd9XOfCl2yIxAlB8A8b4Z5y0gKI8o0GiwIkP', '2014-11-11 08:52:36'),
(24, '4hiZ0abRI3yNb1bGP8BHc0NH8Kof2ymRX3VPGLo1', '2014-11-11 08:53:38'),
(24, 'rvUxNF4CAmyEOzFucUIZz2hE.s.sGxOmakOzgAtW', '2014-11-11 08:56:16'),
(24, 'J.QX139zvBLIPcOO7WM3J4uSGfs3xH.xca5fULrO', '2014-11-11 08:57:23'),
(24, '8LZYNGx/ysgokVcELkU0ues4Uhsdst3esV9W.cIQ', '2014-11-11 08:58:25'),
(24, 'Zz6B/s3NyuJmGJOby/wugYQsN8RCtCcor6pcLhJf', '2014-11-11 08:58:31'),
(24, 'aSFve9rmgiFZ94.7oQWR/z6fgxJkoQdhfT.glEoa', '2014-11-11 08:59:38'),
(24, 'Mohn5EAjzQsAMDc1v2iasnmXUVtg2eXyLGVIAyrm', '2014-11-11 08:59:45'),
(24, 'qaAvrknq5f2qVVmq1lqmwsMctuM9xm2CEfojmUzh', '2014-11-11 09:00:29'),
(24, 'Wypg.LcAD/QUzvbCXlqEf/R3tIWZ6skBFoqZD0i9', '2014-11-11 09:01:57'),
(24, '/10IH7JS4X3XWFAzkNDVsZiWYe4NTk/nSbOKlYct', '2014-11-11 09:04:54'),
(24, 'Kc8ygka3G4H9QBmAIcdl5Dn1uBzRaFUF7WjuJLCC', '2014-11-11 09:06:33'),
(24, 'IIN40WGimUraZAeiK1r10lv5gpqM8HAgZU8MAZJ8', '2014-11-11 09:07:04'),
(24, 'YI3K.wmoqL9nlBxzbDIKlKPuwqJRGuRsly0SPDqJ', '2014-11-11 09:07:15'),
(24, 'uMDSUKx1ImPSsrDN8QNGqIEX5nWyPHx2cOL3fJUM', '2014-11-11 09:17:06'),
(24, 'dWEIupsQ4NEkHwrkqGbrNEgLEFo6ApeohQPLR5iu', '2014-11-11 09:20:55'),
(24, 'Jm8xq8n2cNcLRpuPvUuaLWB01xHzcVRUoUwMv2Hv', '2014-11-11 09:23:14'),
(24, 'a316k7L30HYeyTRxyukED1YtUDCD7RP9bWBP/3mN', '2014-11-11 09:24:10'),
(24, 'DzY0as8IdtuEEkFrh3Aq5BjPn4fW.aA65AsprJ5y', '2014-11-11 09:24:16'),
(24, 'zq0eZaDMuNJQvDkEe8O28XIWpxQ/13Xe7CT2t2r1', '2014-11-11 09:28:09'),
(24, 'E9BNxKFY1AR9jSqFdYjN6.moezhvy6izC08klaKe', '2014-11-11 09:30:06'),
(24, 'hu0dEBmuwso9HZoPnBvwGDkAFsYj7Wg0Z.Dlocol', '2014-11-11 09:46:02'),
(24, '6NKCcKIV6UdWjt//RR.XdCE/AU7CZi8bJIh04rwq', '2014-11-11 09:47:39'),
(24, 'iC0./hmuTl2.2AsxhUWEi9izYm1uTQ91NKHsngYZ', '2014-11-11 09:50:21'),
(24, 'K7pgOB5eA64y/w/.5knDTpwp/xnlXzVfYLADuMGi', '2014-11-11 09:58:53'),
(24, 'YEkZCKXwd87bVHhbk.rq8ktu2Tq4WDxIZg.prQiz', '2014-11-11 10:00:13'),
(24, 'NDRjAnf2HL2I0gdUBE1wgT0T4d.aIAKQxdzXogSK', '2014-11-11 10:01:05'),
(24, 'A7NOFLn5XHO8YowUjkx5kwecgviHW0Mb69WNrwgA', '2014-11-11 10:02:29'),
(24, 'ZC65sGINf9yPPdB6SoPexQXXTIZoCK9.3M7X5C2r', '2014-11-11 10:06:06'),
(24, '2LYqfPefWNXmd//wYxkRcqn2Sc8DeuE13Xp8pfke', '2014-11-11 10:16:32'),
(24, '0vCHbxZPPlcNt9yTE.kF6.akmirMzqSxB5ahxI/Y', '2014-11-11 10:25:15'),
(24, 'etjI5.ht6zQCFu1wzrfsUHO/HEcaQ0rDO5ZRq1Jk', '2014-11-11 10:25:47'),
(24, 'CXbB3l1b6wDutp.lx1L5yAC.wHiWR2nZVbKKX79i', '2014-11-11 10:28:37'),
(24, 'pyxcUDMn9nGMuY3svMlSrP1kxv8R0u9KkVcjRrPX', '2014-11-11 10:34:26'),
(24, 'OQ236qIWmkhSVYFQW69aoNCsgro3Se3OiYdwOJ9Z', '2014-11-11 10:38:15'),
(24, 'o0FAhOHpckAcD9SI/d23FSgeCk0nKo06iQd46Ht/', '2014-11-11 10:38:34'),
(24, 'mTERyHl6jn9.eLWplpKsqeZ2jkMkg8AqrJPAETCF', '2014-11-11 10:41:08'),
(24, 'RPA/UFHJkE/IkYW2ie4szFyjlvlreG4fyu9oO.LE', '2014-11-11 10:43:41'),
(24, 'U30SwmTYIbjYyhlARNl.hpK8J08zFhRRqiwo4nke', '2014-11-11 10:44:15'),
(24, 'R1/6y5qT4obOaMZMXyPdWr/1ig7.qV1jXlreyN1o', '2014-11-11 10:52:56'),
(24, 'l5qR0I9qGx.dkS38PUOOusSwKpFN/DQ50mNVRyo8', '2014-11-11 10:53:52'),
(24, 'NLnPIjGm/1p2yhy4AkXzcpt8p/eH1FQujBjrcQU0', '2014-11-11 10:54:57'),
(18, 'gXt67GsiXq88bbJAskPcbUHqXrMEamptAB5Nc2mO', '2014-11-11 11:00:49'),
(24, '5GyS9ikaqlo9tYkERJ2DlhHuVgecUWfK/fJZL7Om', '2014-11-12 05:24:48'),
(24, 'vXylVDT47dbIt4AYGOkNACyFIJBlt.ERfFm8pM.K', '2014-11-12 05:58:50'),
(24, 'WmwSz/Ex0JmdKHngca27mQv/nltgpDIMnGA1AYxm', '2014-11-12 06:15:19'),
(24, 'pkYIki/VBGH9lyfsdRWBWqYp7LFrqNyx4z7GwhL0', '2014-11-12 06:51:31'),
(24, 'KwVLZLjKp94Yz/Y687kYDW/nBbGNajCkgt9qB/P.', '2014-11-12 06:52:32'),
(24, 'HPHJ5sN7Lg12I85A.GZg6NVuIXmh1dl.lz.D25kj', '2014-11-12 06:53:56'),
(24, '6OI9u1tBxL9S8xDZt6MiN6lHQ7eyDFVpMeXTuj8Y', '2014-11-12 07:03:31'),
(24, 'FLi72lovOANIXImwBT6/Mj2SEgLVU8O45bCwT.QR', '2014-11-12 07:12:37'),
(24, '2M48zT0fZIZZHMwJyP9Qq/p1qP4nQdePF89X89fm', '2014-11-12 07:34:30'),
(24, 'dMnaSWGB92ntX11dxb8AzM2DIAYf2LjYcgoS354K', '2014-11-12 07:38:32'),
(24, 'GK15DrsV6jNyg3W81O7kQX962PmdSqIEj4n7xyYF', '2014-11-12 07:39:54'),
(24, 'scP/GvsV8GG8gMs7Xz9Pmgd761KCTfI0gileS79i', '2014-11-12 07:44:47'),
(24, 'zhtgHY28xuGQ93UolM5xpZ29ZTEiXHnmtIJHQsET', '2014-11-12 07:46:40'),
(24, 'L2cMgMP8jwWoN7MgGfeB419rBwPjdYeaZEnxxXLp', '2014-11-12 07:48:43'),
(24, 'Uab1ZwlfWbrcFnKgsBPiUJ2e0CNNeo/UidOdeXnp', '2014-11-12 07:50:20'),
(24, 'pTrZy6bRQQHaMvt27rCcfVasrBTBtXdKF22GHEuK', '2014-11-12 07:50:56'),
(24, 'swxrkv38ezO55jR7JRafdyPe2Gp/7efzIjEdGeCS', '2014-11-12 07:52:54'),
(24, 'Wm6Tvs4drZSU/KNIbv7Oz/zlyLO026R6OITzU4qc', '2014-11-12 07:53:32'),
(24, 'w8gueYs8vU3y8LeScnAH.tSFeT410oiUxBsKgh60', '2014-11-12 07:54:25'),
(24, 'qZ1BtYmSOunI.WYcJz2uv1inC7amzCzJSvTLVl5i', '2014-11-12 07:54:59'),
(24, 'T5Ru/ccRVl.NJOt45g2rRSHE4TZIJo6vMwkmGWdG', '2014-11-12 07:55:21'),
(24, 'Iioqx0c/wKj9d23ZHsA4BwtnpSxuMqYarMCIY74S', '2014-11-12 07:56:34'),
(24, 'X0.f/DyKwWNCnArWvQmQGFC/ncIFw.J5dwQkPCB1', '2014-11-12 07:58:38'),
(24, 'Moz9IjPmGhIVWjUGgqeDHlCngKdsbDZI.OMbHh/e', '2014-11-12 07:58:59'),
(24, 'PI5YQ40nrooptBXYpnoLlrX77jrOJGLbM.pjOA1R', '2014-11-12 08:07:02'),
(24, 'rRpeJ9W5E7hymNQM0xDpTeyZ0uVomR645coivwKh', '2014-11-12 08:08:00'),
(24, 'CrMVDcYmlEYxoKA9axoVFohZpSTj0PyQI9z4prlj', '2014-11-12 08:08:19'),
(24, 'SrR0t4QlasIDv0ivga.Et6kZQlXKOsHTkBtBAWrk', '2014-11-12 08:20:13'),
(24, 'Vs.8FO5BQUuspl1LxaWES9PZ.qxZpSPPyOi3ECDx', '2014-11-12 08:23:32'),
(24, 'Y1BlGItadNv4YFznUewJuKoh06Y5xIZqLibjUJCe', '2014-11-12 08:27:03'),
(24, '2Ft9gSquHLI5hq6GRPRM8pijIpm8GD0Tovff1s2s', '2014-11-12 08:32:08'),
(24, 'WoNCT0Vm.mi15XHsSLeWJy2fPtNN77dLHz3m6QST', '2014-11-12 08:34:52'),
(24, '2XSG.0WrikAKxFjLsu3JDzJSyS9HfKtzDOeeV3UO', '2014-11-12 08:38:58'),
(24, '3Kn2VstQu2ue/WVr4WbvFzwJQIF.eA2Ml4BJ2n8B', '2014-11-12 08:39:52'),
(24, 'WPAGWPBf.5nd.o07R8YCyD7BkM3aSaRgWHstXyrI', '2014-11-12 08:41:32'),
(24, 'PFA6Pdm1XZXsNRn5sX1.1tlQsKHAcb2xI5nU0633', '2014-11-12 08:42:52'),
(24, 'l0joyeJLbCSz4KUoUdnzFNWNcgRB6Q.P7sK.7ZRQ', '2014-11-12 08:43:23'),
(24, 'PzvfGhBEQFOrj03kTaIPOQXwFuHGyua0AL8zMyz8', '2014-11-12 08:45:04'),
(24, 'XOMVAlDEFxfTqW9QnIQGkUHS0nyO.x45CaZ/gVbz', '2014-11-12 08:47:44'),
(24, 'qVZg8I23iaYfnZX8lAwBvpEOCGspTt9Tc/3asJAh', '2014-11-12 09:02:38'),
(24, 'hbnmUv1P28U9q4IZiajaMkSl9knUjfqQ87nGMhYl', '2014-11-12 09:05:14'),
(18, 'mNSdXkvRqMIkEs2x3s7aBLzxOj.KiFkR9ZoEtuLc', '2014-11-12 09:06:22'),
(24, 'yNRDx0UUfb.ESYYIMHkOeehAMo9gNOEfiRygNBJb', '2014-11-12 09:16:09'),
(18, 'yz7tyjgYwNZYe9GzInmhkGFCz8wm1Msmj7N6LLjA', '2014-11-12 10:16:25'),
(18, 'PR2BcJnHYh9KoFRXjQ..KLx350z6Z08cM0kn/HsS', '2014-11-12 11:02:24'),
(18, '9MlHmcjdaARlhNT2560bGqQYQIcCAaB18QuGE6CD', '2014-11-12 11:03:21'),
(18, 'UH.rojlRUFCDzqk0NC3iLGnxegWnVjFnRhYqRwPB', '2014-11-12 11:12:03'),
(24, 'FNLk6oBr9OfvfcCdJAbPYXjdOAIah1wwDH3I3.En', '2014-11-12 11:12:27'),
(24, 'GWjFuq1LJBQUrP7tCgsPENdXyDBMZ6lK.XDCLOjC', '2014-11-12 11:14:02'),
(18, '/R0wl5JUM63JvRSJ6v5yMwDgkLViMZnpTf//fpUc', '2014-11-12 11:21:03'),
(18, 'e5vwFrRzOykojKddDkxGeuWoNYgFSxyzysW1wd4D', '2014-11-12 11:25:22'),
(18, 'wzw9LTx5pZxqKIjn5XC5OfaVg180.SQ834mv3VBE', '2014-11-12 11:30:15'),
(18, 'QKXb1HfIkCQterxAZHz.8oRdaWdjxi972jG7xqj9', '2014-11-12 11:30:46'),
(18, 'JhgJ9NCQykZTYvQC5KZzKKGJKtrwgH04WLd9gMvg', '2014-11-12 11:31:13'),
(18, 'QL1jPyWWFb2pH0I43.ewTPOsbjkzDWPvyscrYw4W', '2014-11-12 11:36:42'),
(24, '7GBVYCKJRRa/N9jghOhvHa24pdmNMCAXYGzujeVY', '2014-11-12 11:38:48'),
(18, 'cHXATSmyZ.icR6cFUwPsB082IotbVC8Kx3mjN0fB', '2014-11-12 11:39:32'),
(18, 'Vem2vReDhe7kwBMXFkRMxTqQK5lKQ9MASuwV9hCJ', '2014-11-12 11:40:52'),
(18, '7yrApf/FPwHFCT4.W7QelCN7PYe/cu2acsJF4tJw', '2014-11-12 11:41:56'),
(18, 'hRAgxvoa0.mKCCxLFPXIZ0pF2UFdn7PoCAi4AyHc', '2014-11-12 11:44:08'),
(18, '88DHX3LxujJV67cyrrdxpfUMwSAq5A4cHj9p1kic', '2014-11-12 11:45:34'),
(18, '9QH3aAd3ixasYtMCIJmjZnjfv4DwYqDsHvHfMnF8', '2014-11-12 11:46:28'),
(24, 'fAVXSI2FHRRlL2l/yKvKUDoQO.z2PbeHBdOq1ZlG', '2014-11-12 11:53:32'),
(24, 'TgAJwX.EouEIagxTakQmf7p24aFwMTsK9bL5sPfs', '2014-11-12 11:55:30'),
(24, 'gYZv.s/L.K5u39MqFMhWNkqNnIlYMVPLBy0sBLfc', '2014-11-12 11:56:12'),
(18, 'xlxIIexPfisgczWrxArOBsALWT6JX1GkVt9PVoe.', '2014-11-12 11:58:35');

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
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) NOT NULL,
  `location_id` int(10) DEFAULT NULL,
  `departure_id` int(10) unsigned DEFAULT NULL,
  `size` int(10) NOT NULL DEFAULT '0',
  `destination_id` int(10) DEFAULT NULL,
  `departure_time` int(11) unsigned DEFAULT NULL,
  `arrival_time` int(11) unsigned DEFAULT NULL,
  `battle_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`,`location_id`,`destination_id`,`battle_id`),
  KEY `location_id` (`location_id`),
  KEY `destination_id` (`destination_id`),
  KEY `battle_id` (`battle_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=378 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `departure_id`, `size`, `destination_id`, `departure_time`, `arrival_time`, `battle_id`) VALUES
(353, 31, 11601, NULL, 379, NULL, NULL, NULL, NULL),
(354, 26, 11613, NULL, 379, NULL, NULL, NULL, NULL),
(355, 18, 11617, NULL, 91, NULL, NULL, NULL, NULL),
(356, 25, 11638, NULL, 379, NULL, NULL, NULL, NULL),
(357, 27, 11640, NULL, 379, NULL, NULL, NULL, NULL),
(358, 30, 11643, NULL, 379, NULL, NULL, NULL, NULL),
(359, 24, 11643, NULL, 8, NULL, NULL, NULL, NULL),
(360, 28, 11648, NULL, 379, NULL, NULL, NULL, NULL),
(361, 29, 11652, NULL, 379, NULL, NULL, NULL, NULL),
(368, 24, 11641, NULL, 33, NULL, NULL, NULL, NULL),
(369, 18, 11615, NULL, 110, 11612, 1415790854, 1415791802, NULL),
(370, 24, 11642, NULL, 39, NULL, NULL, NULL, NULL),
(371, 18, 11615, NULL, 25, NULL, NULL, NULL, NULL),
(372, 24, 11643, NULL, 265, NULL, NULL, NULL, NULL),
(373, 18, 11614, NULL, 14, NULL, NULL, NULL, NULL),
(374, 18, 11617, NULL, 67, 11612, 1415790856, 1415791728, NULL),
(375, 18, 11616, NULL, 24, NULL, NULL, NULL, NULL),
(376, 24, 11644, NULL, 29, NULL, NULL, NULL, NULL),
(377, 18, 11618, NULL, 12, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `game_settings`
--

CREATE TABLE IF NOT EXISTS `game_settings` (
  `time_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resource_pool` int(10) NOT NULL,
  `max_players` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `game_settings`
--

INSERT INTO `game_settings` (`time_started`, `resource_pool`, `max_players`) VALUES
('2014-11-12 10:38:26', 0, 12);

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
  `type` varchar(20) NOT NULL,
  `resources` int(10) NOT NULL,
  `size` tinyint(3) NOT NULL,
  `mines` tinyint(3) NOT NULL DEFAULT '0',
  `shipyards` tinyint(3) NOT NULL DEFAULT '0',
  `labs` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_id` (`system_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11653 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `name`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(11601, 31, 2430, 896, 629, 'stera vet la ', 'desert', 2, 9, 1, 1, 1),
(11602, NULL, 2430, 128, 948, 'vet cebiri ', 'volcanic', 5, 9, 0, 0, 0),
(11603, NULL, 2430, 776, 34, 'dit tha', 'molten', 6, 14, 0, 0, 0),
(11604, NULL, 2430, 204, 604, 'ditsla', 'molten', 6, 6, 0, 0, 0),
(11605, NULL, 2430, 172, 335, 'thedit', 'molten', 6, 4, 0, 0, 0),
(11606, NULL, 2430, 80, 424, 'thetha', 'volcanic', 5, 6, 0, 0, 0),
(11607, NULL, 2430, 500, 500, 'gezse', 'redGiant', 0, 46, 0, 0, 0),
(11608, NULL, 2431, 396, 430, 'qua thecebiste so ', 'ice', 1, 6, 0, 0, 0),
(11609, NULL, 2431, 70, 198, 'ste ra ', 'ice', 1, 6, 0, 0, 0),
(11610, NULL, 2431, 497, 263, 'berronas gezso re ', 'volcanic', 5, 4, 0, 0, 0),
(11611, NULL, 2431, 500, 500, 'diraber gezvet min ', 'yellowStar', 0, 14, 0, 0, 0),
(11612, 18, 2432, 886, 68, 'lacebi ', 'molten', 6, 9, 1, 0, 0),
(11613, 26, 2432, 300, 767, 'ladittha qua dinas ', 'ice', 1, 6, 1, 1, 1),
(11614, 18, 2432, 307, 401, 'quacebi rotha', 'volcanic', 5, 6, 1, 0, 0),
(11615, 18, 2432, 3, 414, 'lex ri', 'volcanic', 5, 4, 1, 0, 0),
(11616, 18, 2432, 263, 204, 'rasolexdi ', 'ice', 1, 4, 1, 0, 0),
(11617, 18, 2432, 14, 60, 'minthe', 'molten', 6, 4, 1, 0, 0),
(11618, 18, 2432, 500, 500, 'ro sla', 'blueGiant', 0, 30, 1, 1, 1),
(11619, NULL, 2433, 870, 678, 'nasvet qua somin ', 'ice', 1, 6, 0, 0, 0),
(11620, NULL, 2433, 4, 156, 'sothe nas ', 'volcanic', 5, 4, 0, 0, 0),
(11621, NULL, 2433, 322, 209, 'nasmin', 'terran', 3, 4, 0, 0, 0),
(11622, NULL, 2433, 500, 500, 'netri di ', 'blueStar', 0, 14, 0, 0, 0),
(11623, NULL, 2434, 677, 321, 'cebise cebi', 'molten', 6, 9, 0, 0, 0),
(11624, NULL, 2434, 142, 736, 'ri gez', 'molten', 6, 6, 0, 0, 0),
(11625, NULL, 2434, 784, 637, 'quathanasqua', 'molten', 6, 4, 0, 0, 0),
(11626, NULL, 2434, 263, 229, 'nas solamin so so', 'ice', 1, 4, 0, 0, 0),
(11627, NULL, 2434, 500, 500, 'tha nastel thaberlex', 'blueStar', 0, 20, 0, 0, 0),
(11628, NULL, 2435, 436, 536, 'nas ra ', 'volcanic', 5, 6, 0, 0, 0),
(11629, NULL, 2435, 188, 547, 'la gez', 'desert', 2, 6, 0, 0, 0),
(11630, NULL, 2435, 116, 841, 'sodi ', 'desert', 2, 6, 0, 0, 0),
(11631, NULL, 2435, 749, 540, 'thera', 'molten', 6, 4, 0, 0, 0),
(11632, NULL, 2435, 500, 500, 'ro gez ', 'blueStar', 0, 20, 0, 0, 0),
(11633, NULL, 2436, 532, 137, 'qua sla tha', 'molten', 6, 6, 0, 0, 0),
(11634, NULL, 2436, 375, 673, 'ra mincebi ', 'molten', 6, 6, 0, 0, 0),
(11635, NULL, 2436, 392, 60, 'redi re cebi la ', 'ice', 1, 4, 0, 0, 0),
(11636, NULL, 2436, 72, 321, 'slagez ', 'desert', 2, 4, 0, 0, 0),
(11637, NULL, 2436, 725, 279, 'lex tha', 'ice', 1, 6, 0, 0, 0),
(11638, 25, 2436, 530, 368, 'vet se ', 'desert', 2, 4, 1, 1, 1),
(11639, NULL, 2436, 694, 884, 'mingez', 'terran', 3, 4, 0, 0, 0),
(11640, 27, 2436, 500, 500, 'slalex di vet se', 'redGiant', 0, 30, 1, 1, 1),
(11641, 24, 2437, 597, 317, 'ditla', 'terran', 3, 6, 0, 0, 0),
(11642, 24, 2437, 329, 958, 'tel soqua', 'molten', 6, 6, 0, 0, 0),
(11643, 30, 2437, 88, 647, 'ratel', 'ice', 1, 6, 1, 1, 1),
(11644, 24, 2437, 392, 191, 'qua se', 'desert', 2, 4, 1, 1, 1),
(11645, 24, 2437, 500, 500, 'net net ra ', 'blueStar', 0, 20, 0, 0, 0),
(11646, NULL, 2438, 733, 458, 'tha tha the ', 'desert', 2, 4, 0, 0, 0),
(11647, NULL, 2438, 584, 270, 'diranet slacebi ', 'desert', 2, 4, 0, 0, 0),
(11648, 28, 2438, 606, 563, 'di bernas ra', 'ice', 1, 4, 1, 1, 1),
(11649, NULL, 2438, 500, 500, 'dittel', 'whiteDwarf', 0, 9, 0, 0, 0),
(11650, NULL, 2439, 909, 321, 'telbertel net', 'desert', 2, 4, 0, 0, 0),
(11651, NULL, 2439, 434, 163, 'lexber', 'ice', 1, 4, 0, 0, 0),
(11652, 29, 2439, 500, 500, 'lexgezberla ber ', 'redDwarf', 0, 6, 1, 1, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2440 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `name`, `size`, `type`) VALUES
(2430, 1, 383, 903, 'gezse', 46, 'redGiant'),
(2431, 1, 441, 684, 'diraber gezvet min ', 14, 'yellowStar'),
(2432, 1, 195, 136, 'ro sla', 30, 'blueGiant'),
(2433, 1, 788, 968, 'netri di ', 14, 'blueStar'),
(2434, 1, 560, 242, 'tha nastel thaberlex', 20, 'blueStar'),
(2435, 1, 60, 770, 'ro gez ', 20, 'blueStar'),
(2436, 1, 366, 67, 'slalex di vet se', 30, 'redGiant'),
(2437, 1, 582, 971, 'net net ra ', 20, 'blueStar'),
(2438, 1, 750, 54, 'dittel', 9, 'whiteDwarf'),
(2439, 1, 28, 917, 'lexgezberla ber ', 6, 'redDwarf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `username`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(18, 3, 1, '2q3o3CHLwvtDcLDe8xsM7g846NZ.zvfRC8c7PHHt', 'admin', 'NphdFxVrXT8ueLpZgNfUemtghjlj/iBJoKm8v3ec', 'e344575382996d08c8ad8bc6e809cd6e93216226249ce1ca70b038eac0341669d8f1985d5eeafbf57aee7236330ad208', 287, 0, 0, 0),
(24, 3, 0, 'gTwgSzD/fGObIqd9aW3dBOYzzcnu6AmaDQ/W4tjV', 'david.miller8@mohawkcollege.ca', 'xzpEmrZtfjBgzoxyrjV9vkFOnL1ctpz.OneCuUob', 'b5d95b79d96252d75168b0ccd5c9448902c65f439dba6b558e7aa6b724e486e22fa944148dacc332db57d2698b9b4b91', 808, 0, 0, 0),
(25, 3, 0, 'LH/JALlkHRBYNSnaD8xUwTttu4DeGl/VQ7lkm3H/', 'test1', '.cTJHTYSrGURi91p1PZfM.Mzo7llpUMiAlxojCyF', 'cc0c537d1c0e40838014fbd212f9a2603b60ae49a291c64816e1d86a9c8f0d2560172c831b572ef79c0dfdc555954582', 808, 0, 0, 0),
(26, 3, 0, 'a/mPf7haq1ifXilOY0Le6d5V6W1xu4rlOmaoCxDn', 'test2', 'nuBg7sBpLXMCETn0pOjTeAt53V2eYz2iSd7ZacWq', '67820944d22699d7ae2c0ef008d4377758e85ec4692fc91a8d015fda4defbb72c93ac6e50591fa4cdb58a7e45923b058', 429, 0, 0, 0),
(27, 3, 0, 'egnfcNVuCaS38mli2q4.Pd2t7Vv1ej.3.gmBUVJb', 'test3', 'jHYgpPLAyBIlxQ2CTIxTfmjtInBG3Dw3qt8j0/tg', '62383b44970b2a8ca85ecf097ba01e9a839c039f3ece917be7f149a98103b9cecd5408d253919dfe99d20f37d9367f36', 50, 0, 0, 0),
(28, 3, 0, 'Rwx7XTK2713d4uPcpJkyEQBszUsskn5PoPEAjFtG', 'test4', '6C0z3BPLcvwF10ECwZ8aA6pOqrcii8nbrCdZ2cW5', 'd8d56a61eae4ad43d0494d4ef305af34bbd764cdb07fc45bff46eef38cbb270e4b4b8538d108672d39087bc8b2036d7c', 429, 0, 0, 0),
(29, 3, 0, '/IwMt9PWlLIijHZGeNmmzONdfYLZ8QJanJGWTOgx', 'test5', '9g5lwC2wi4czMQykfLp3sOv4QiTYgIim4QQ2YE0n', '4df17447b957352306c2363e7c08cb7a512060e129034f422d7a21b7ccbda93626ab123cbfa7e6d653307d4dd611ba11', 50, 0, 0, 0),
(30, 3, 0, 'YODqLrNezQivVK/nXq7mCRxygdQ.gP0.daWGRfT6', 'test6', '7NiUqZb9u6DX3iYYRWhfwBvSnmlhbq8JMe7pJ9pm', '22d047dd484b3991e4f462c7e84d83c9eca0c824973bc9e5a2d611ca09c61daa638a7d1ea8c8ea90112d19647e6c623f', 429, 0, 0, 0),
(31, 3, 0, 'A0DS415ZL.cX69nAogKhXtK5KH4yHDThyftlFZux', '', 'dwox1G6Uml11kpi9ujDDkDT.aLXp/GMfTikU.3c4', '797bca45e99e3f77950f2b06bea9c1b898cdeb14f90eeae540c58bb436d47813bd923525b747d30942f4bca247aa1480', 808, 0, 0, 0);

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
