-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 09, 2014 at 01:37 AM
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
(18, 'Fokdk/k9bHBklVSxZtX27YrfJ5XGr6C1Q7gFO11d', '2014-11-09 02:09:07');

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
  `size` int(10) NOT NULL DEFAULT '0',
  `destination_id` int(10) DEFAULT NULL,
  `arrival_time` timestamp NULL DEFAULT NULL,
  `battle_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`,`location_id`,`destination_id`,`battle_id`),
  KEY `location_id` (`location_id`),
  KEY `destination_id` (`destination_id`),
  KEY `battle_id` (`battle_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `fleets`
--

INSERT INTO `fleets` (`id`, `owner_id`, `location_id`, `size`, `destination_id`, `arrival_time`, `battle_id`) VALUES
(1, 29, 10491, 2, NULL, NULL, NULL),
(2, 28, 10512, 2, NULL, NULL, NULL),
(3, 27, 10515, 2, NULL, NULL, NULL),
(4, 24, 10518, 2, NULL, NULL, NULL),
(5, 25, 10532, 2, NULL, NULL, NULL),
(6, 30, 10540, 2, NULL, NULL, NULL);

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
('2014-11-09 00:19:27', 0, 12);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10543 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `owner_id`, `system_id`, `position_x`, `position_y`, `type`, `resources`, `size`, `mines`, `shipyards`, `labs`) VALUES
(10490, NULL, 2188, 799, 564, 'volcanic', 5, 6, 0, 0, 0),
(10491, 29, 2188, 76, 648, 'molten', 6, 9, 1, 1, 1),
(10492, NULL, 2188, 308, 381, 'desert', 2, 9, 0, 0, 0),
(10493, NULL, 2188, 726, 644, 'desert', 2, 9, 0, 0, 0),
(10494, NULL, 2188, 286, 966, 'molten', 6, 4, 0, 0, 0),
(10495, NULL, 2188, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(10496, NULL, 2189, 737, 535, 'terran', 3, 6, 0, 0, 0),
(10497, NULL, 2189, 490, 821, 'molten', 6, 4, 0, 0, 0),
(10498, NULL, 2189, 531, 89, 'terran', 3, 14, 0, 0, 0),
(10499, NULL, 2189, 134, 73, 'ice', 1, 9, 0, 0, 0),
(10500, NULL, 2189, 500, 500, 'blueGiant', 0, 30, 0, 0, 0),
(10501, NULL, 2190, 336, 71, 'ice', 1, 4, 0, 0, 0),
(10502, NULL, 2190, 118, 190, 'ice', 1, 9, 0, 0, 0),
(10503, NULL, 2190, 854, 2, 'ice', 1, 4, 0, 0, 0),
(10504, NULL, 2190, 404, 355, 'molten', 6, 4, 0, 0, 0),
(10505, NULL, 2190, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10506, NULL, 2191, 847, 102, 'terran', 3, 6, 0, 0, 0),
(10507, NULL, 2191, 332, 215, 'ice', 1, 4, 0, 0, 0),
(10508, NULL, 2191, 76, 593, 'ice', 1, 6, 0, 0, 0),
(10509, NULL, 2191, 636, 259, 'molten', 6, 4, 0, 0, 0),
(10510, NULL, 2191, 446, 990, 'ice', 1, 4, 0, 0, 0),
(10511, NULL, 2191, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10512, 28, 2192, 955, 865, 'molten', 6, 4, 1, 1, 1),
(10513, NULL, 2192, 476, 114, 'terran', 3, 4, 0, 0, 0),
(10514, NULL, 2192, 36, 31, 'terran', 3, 9, 0, 0, 0),
(10515, 27, 2192, 304, 574, 'ice', 1, 6, 1, 1, 1),
(10516, NULL, 2192, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10517, NULL, 2193, 357, 353, 'volcanic', 5, 9, 0, 0, 0),
(10518, 24, 2193, 514, 215, 'volcanic', 5, 4, 1, 1, 1),
(10519, NULL, 2193, 157, 285, 'volcanic', 5, 4, 0, 0, 0),
(10520, NULL, 2193, 563, 879, 'ice', 1, 4, 0, 0, 0),
(10521, NULL, 2193, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10522, NULL, 2194, 616, 352, 'ice', 1, 9, 0, 0, 0),
(10523, NULL, 2194, 161, 91, 'terran', 3, 6, 0, 0, 0),
(10524, NULL, 2194, 436, 417, 'terran', 3, 4, 0, 0, 0),
(10525, NULL, 2194, 363, 209, 'molten', 6, 4, 0, 0, 0),
(10526, NULL, 2194, 500, 500, 'yellowStar', 0, 20, 0, 0, 0),
(10527, NULL, 2195, 458, 943, 'molten', 6, 4, 0, 0, 0),
(10528, NULL, 2195, 985, 152, 'terran', 3, 4, 0, 0, 0),
(10529, NULL, 2195, 676, 675, 'terran', 3, 4, 0, 0, 0),
(10530, NULL, 2195, 500, 500, 'redDwarf', 0, 9, 0, 0, 0),
(10531, NULL, 2196, 518, 159, 'ice', 1, 4, 0, 0, 0),
(10532, 25, 2196, 162, 195, 'molten', 6, 4, 1, 1, 1),
(10533, NULL, 2196, 276, 341, 'volcanic', 5, 4, 0, 0, 0),
(10534, NULL, 2196, 808, 814, 'desert', 2, 6, 0, 0, 0),
(10535, NULL, 2196, 686, 83, 'ice', 1, 4, 0, 0, 0),
(10536, NULL, 2196, 500, 500, 'blueStar', 0, 20, 0, 0, 0),
(10537, NULL, 2197, 860, 86, 'ice', 1, 4, 0, 0, 0),
(10538, NULL, 2197, 377, 148, 'desert', 2, 4, 0, 0, 0),
(10539, NULL, 2197, 792, 325, 'molten', 6, 4, 0, 0, 0),
(10540, 30, 2197, 500, 500, 'redDwarf', 0, 9, 1, 1, 1),
(10541, NULL, 2198, 424, 207, 'molten', 6, 6, 0, 0, 0),
(10542, NULL, 2198, 500, 500, 'whiteDwarf', 0, 6, 0, 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2199 ;

--
-- Dumping data for table `systems`
--

INSERT INTO `systems` (`id`, `sector_id`, `position_x`, `position_y`, `size`, `type`) VALUES
(2188, 1, 871, 444, 30, 'blueGiant'),
(2189, 1, 786, 211, 30, 'blueGiant'),
(2190, 1, 39, 576, 20, 'blueStar'),
(2191, 1, 869, 527, 20, 'blueStar'),
(2192, 1, 445, 728, 20, 'blueStar'),
(2193, 1, 402, 401, 20, 'blueStar'),
(2194, 1, 636, 470, 20, 'yellowStar'),
(2195, 1, 144, 334, 9, 'redDwarf'),
(2196, 1, 757, 51, 20, 'blueStar'),
(2197, 1, 235, 901, 9, 'redDwarf'),
(2198, 1, 441, 63, 6, 'whiteDwarf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `status`, `is_admin`, `username`, `email`, `salt`, `password`, `resources`, `tech_weapons`, `tech_propulsion`, `tech_armour`) VALUES
(18, 3, 1, '2q3o3CHLwvtDcLDe8xsM7g846NZ.zvfRC8c7PHHt', 'admin', 'NphdFxVrXT8ueLpZgNfUemtghjlj/iBJoKm8v3ec', 'e344575382996d08c8ad8bc6e809cd6e93216226249ce1ca70b038eac0341669d8f1985d5eeafbf57aee7236330ad208', 4, 0, 0, 0),
(24, 3, 0, 'gTwgSzD/fGObIqd9aW3dBOYzzcnu6AmaDQ/W4tjV', 'david.miller8@mohawkcollege.ca', 'xzpEmrZtfjBgzoxyrjV9vkFOnL1ctpz.OneCuUob', 'b5d95b79d96252d75168b0ccd5c9448902c65f439dba6b558e7aa6b724e486e22fa944148dacc332db57d2698b9b4b91', 24, 0, 0, 0),
(25, 3, 0, 'LH/JALlkHRBYNSnaD8xUwTttu4DeGl/VQ7lkm3H/', 'test1', '.cTJHTYSrGURi91p1PZfM.Mzo7llpUMiAlxojCyF', 'cc0c537d1c0e40838014fbd212f9a2603b60ae49a291c64816e1d86a9c8f0d2560172c831b572ef79c0dfdc555954582', 0, 0, 0, 0),
(26, 3, 0, 'a/mPf7haq1ifXilOY0Le6d5V6W1xu4rlOmaoCxDn', 'test2', 'nuBg7sBpLXMCETn0pOjTeAt53V2eYz2iSd7ZacWq', '67820944d22699d7ae2c0ef008d4377758e85ec4692fc91a8d015fda4defbb72c93ac6e50591fa4cdb58a7e45923b058', 0, 0, 0, 0),
(27, 3, 0, 'egnfcNVuCaS38mli2q4.Pd2t7Vv1ej.3.gmBUVJb', 'test3', 'jHYgpPLAyBIlxQ2CTIxTfmjtInBG3Dw3qt8j0/tg', '62383b44970b2a8ca85ecf097ba01e9a839c039f3ece917be7f149a98103b9cecd5408d253919dfe99d20f37d9367f36', 0, 0, 0, 0),
(28, 3, 0, 'Rwx7XTK2713d4uPcpJkyEQBszUsskn5PoPEAjFtG', 'test4', '6C0z3BPLcvwF10ECwZ8aA6pOqrcii8nbrCdZ2cW5', 'd8d56a61eae4ad43d0494d4ef305af34bbd764cdb07fc45bff46eef38cbb270e4b4b8538d108672d39087bc8b2036d7c', 0, 0, 0, 0),
(29, 3, 0, '/IwMt9PWlLIijHZGeNmmzONdfYLZ8QJanJGWTOgx', 'test5', '9g5lwC2wi4czMQykfLp3sOv4QiTYgIim4QQ2YE0n', '4df17447b957352306c2363e7c08cb7a512060e129034f422d7a21b7ccbda93626ab123cbfa7e6d653307d4dd611ba11', 0, 0, 0, 0),
(30, 3, 0, 'YODqLrNezQivVK/nXq7mCRxygdQ.gP0.daWGRfT6', 'test6', '7NiUqZb9u6DX3iYYRWhfwBvSnmlhbq8JMe7pJ9pm', '22d047dd484b3991e4f462c7e84d83c9eca0c824973bc9e5a2d611ca09c61daa638a7d1ea8c8ea90112d19647e6c623f', 0, 0, 0, 0);

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
