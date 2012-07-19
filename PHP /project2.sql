/*
 Navicat Premium Data Transfer

 Source Server         : bigyellowcat
 Source Server Type    : MySQL
 Source Server Version : 50051
 Source Host           : bigyellowcat.cs.binghamton.edu
 Source Database       : alti

 Target Server Type    : MySQL
 Target Server Version : 50051
 File Encoding         : utf-8

 Date: 11/29/2009 20:51:23 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `clients`
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `room_id` int(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `age` tinyint(4) default NULL,
  `gender` varchar(45) default NULL,
  `notes` text,
  PRIMARY KEY  (`id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `clients`
-- ----------------------------
INSERT INTO `clients` VALUES ('1', '1', 'john', 'doe', '22', 'Male', 'homeless'), ('2', '1', 'jane', 'doe', '20', 'Female', ''), ('3', '1', 'jim', 'doe', '12', 'Male', '');

-- ----------------------------
--  Table structure for `organizations`
-- ----------------------------
DROP TABLE IF EXISTS `organizations`;
CREATE TABLE `organizations` (
  `name` varchar(45) NOT NULL default '',
  `admin` varchar(45) NOT NULL,
  `address` varchar(255) default NULL,
  `phone` varchar(45) default NULL,
  PRIMARY KEY  (`name`),
  KEY `admin` (`admin`),
  CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`admin`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `organizations`
-- ----------------------------
INSERT INTO `organizations` VALUES ('org1', 'cenk', 'somewhere', '5555555');

-- ----------------------------
--  Table structure for `rooms`
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` int(11) NOT NULL auto_increment,
  `shelter` varchar(45) NOT NULL,
  `type` varchar(45) default NULL,
  `available` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `men` tinyint(1) default NULL,
  `women` tinyint(1) default NULL,
  `mothers` tinyint(1) default NULL,
  `boys` tinyint(1) default NULL,
  `girls` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `shelter` (`shelter`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`shelter`) REFERENCES `shelters` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `rooms`
-- ----------------------------
INSERT INTO `rooms` VALUES ('1', 'shelter1', 'some room', '0', '3', '1', '0', '0', '0', '0'), ('2', 'shelter1', '', '0', '0', '1', '1', '1', '1', '1');

-- ----------------------------
--  Table structure for `shelters`
-- ----------------------------
DROP TABLE IF EXISTS `shelters`;
CREATE TABLE `shelters` (
  `name` varchar(45) NOT NULL default '',
  `organization` varchar(45) NOT NULL,
  `desk_worker` varchar(45) NOT NULL,
  `address` varchar(45) default NULL,
  `phone` varchar(45) default NULL,
  PRIMARY KEY  (`name`),
  KEY `organization` (`organization`),
  KEY `desk_worker` (`desk_worker`),
  CONSTRAINT `shelters_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shelters_ibfk_2` FOREIGN KEY (`desk_worker`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `shelters`
-- ----------------------------
INSERT INTO `shelters` VALUES ('shelter1', 'org1', 'nesil', 'here', '123');

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `users`
-- ----------------------------
INSERT INTO `users` VALUES ('cenk', 'cenk', 'Organization Admin'), ('nesil', 'nesil', 'Desk Worker'), ('sysadmin', 'sysadmin', 'System Admin');

