-- phpMyAdmin SQL Dump
-- version 3.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 09, 2009 at 11:54 AM
-- Server version: 5.0.51
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `alti`
--

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `rooms_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`rooms_id`),
  KEY `fk_clients_rooms1` (`rooms_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `clients`
--


-- --------------------------------------------------------

--
-- Table structure for table `desk_workers`
--

CREATE TABLE IF NOT EXISTS `desk_workers` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `shelters_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`shelters_id`),
  KEY `fk_desk_workers_shelters` (`shelters_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `desk_workers`
--

INSERT INTO `desk_workers` (`id`, `username`, `password`, `shelters_id`) VALUES
(0, 'worker1', 'worker1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `contact` varchar(45) default NULL,
  `address` varchar(45) default NULL,
  `phone` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `contact`, `address`, `phone`) VALUES
(0, 'YWCA', 'Jane Smith', '123 somewhere', '1234567'),
(1, 'another org.', 'John Doe', '555 faraway', '7654321'),
(2, 'An Organization', 'Cenk Alti', '4400 Vestal Parkway E', '5555555');

-- --------------------------------------------------------

--
-- Table structure for table `organization_admins`
--

CREATE TABLE IF NOT EXISTS `organization_admins` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `organizations_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`organizations_id`),
  KEY `fk_administrative_users_organizations1` (`organizations_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `organization_admins`
--

INSERT INTO `organization_admins` (`id`, `username`, `password`, `organizations_id`) VALUES
(0, 'admin0', 'admin0', 0),
(1, 'admin1', 'admin1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) default NULL,
  `capacity` int(11) NOT NULL,
  `available` int(11) NOT NULL,
  `organizations_id` int(11) NOT NULL,
  `gender` varchar(45) default NULL,
  PRIMARY KEY  (`id`,`organizations_id`),
  KEY `fk_rooms_organizations1` (`organizations_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `type`, `capacity`, `available`, `organizations_id`, `gender`) VALUES
(0, 'Dormitory', 16, 8, 0, 'Adult Men'),
(1, 'Rooms (single)', 6, 3, 0, 'Adult Women'),
(2, 'Rooms (double)', 12, 9, 0, ''),
(3, 'Rooms (Single)', 10, 5, 1, 'Adult (Men)'),
(4, 'Dormitory', 20, 13, 2, 'Adult (Men)'),
(5, 'Dormitory', 20, 10, 2, 'Adult (Women)');

-- --------------------------------------------------------

--
-- Table structure for table `shelters`
--

CREATE TABLE IF NOT EXISTS `shelters` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `shelters`
--

INSERT INTO `shelters` (`id`, `name`) VALUES
(0, 'shelter1');

-- --------------------------------------------------------

--
-- Table structure for table `system_admins`
--

CREATE TABLE IF NOT EXISTS `system_admins` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `system_admins`
--

INSERT INTO `system_admins` (`id`, `username`, `password`) VALUES
(0, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vacancy_report`
--
CREATE TABLE IF NOT EXISTS `vacancy_report` (
`Organization` varchar(45)
,`contact` varchar(45)
,`address` varchar(45)
,`phone` varchar(45)
,`type` varchar(45)
,`capacity` int(11)
,`available` int(11)
,`gender` varchar(45)
);
-- --------------------------------------------------------

--
-- Structure for view `vacancy_report`
--
DROP TABLE IF EXISTS `vacancy_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`alti`@`localhost` SQL SECURITY DEFINER VIEW `vacancy_report` AS select `organizations`.`name` AS `Organization`,`organizations`.`contact` AS `contact`,`organizations`.`address` AS `address`,`organizations`.`phone` AS `phone`,`rooms`.`type` AS `type`,`rooms`.`capacity` AS `capacity`,`rooms`.`available` AS `available`,`rooms`.`gender` AS `gender` from (`rooms` join `organizations` on((`rooms`.`organizations_id` = `organizations`.`id`))) order by `organizations`.`name`,`rooms`.`available` desc;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `fk_clients_rooms1` FOREIGN KEY (`rooms_id`) REFERENCES `rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `desk_workers`
--
ALTER TABLE `desk_workers`
  ADD CONSTRAINT `fk_desk_workers_shelters` FOREIGN KEY (`shelters_id`) REFERENCES `shelters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `organization_admins`
--
ALTER TABLE `organization_admins`
  ADD CONSTRAINT `fk_administrative_users_organizations1` FOREIGN KEY (`organizations_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_rooms_organizations1` FOREIGN KEY (`organizations_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
