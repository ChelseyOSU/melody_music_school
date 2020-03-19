/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : bsg2

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2020-03-01 17:17:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES ('101', 'Classic Music Theory', 'This course introduces students to diatonic harmonic analysis in various musical textures, melody writing, and harmonization of melodies in various musical textures.');
INSERT INTO `classes` VALUES ('228', 'Survey of Jazz Composition and Arranging', 'A comprehensive study of the evolution of jazz arranging and composition from the 1920s to the present.');
INSERT INTO `classes` VALUES ('401', 'Popular Music Institute', 'This experiential course provides students with the practical and analytical skills needed to develop a successful touring act chosen from among their fellow students.');

-- ----------------------------
-- Table structure for enrollments
-- ----------------------------
DROP TABLE IF EXISTS `enrollments`;
CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of enrollments
-- ----------------------------
INSERT INTO `enrollments` VALUES ('1', '2', '228');
INSERT INTO `enrollments` VALUES ('2', '2', '401');
INSERT INTO `enrollments` VALUES ('3', '1', '228');
INSERT INTO `enrollments` VALUES ('4', '1', '101');
INSERT INTO `enrollments` VALUES ('5', '1', '401');
INSERT INTO `enrollments` VALUES ('6', '5', '101');
INSERT INTO `enrollments` VALUES ('7', '5', '401');
INSERT INTO `enrollments` VALUES ('8', '4', '101');
INSERT INTO `enrollments` VALUES ('9', '4', '228');
INSERT INTO `enrollments` VALUES ('10', '4', '401');
INSERT INTO `enrollments` VALUES ('11', '3', '401');
INSERT INTO `enrollments` VALUES ('12', '3', '228');

-- ----------------------------
-- Table structure for grade_report
-- ----------------------------
DROP TABLE IF EXISTS `grade_report`;
CREATE TABLE `grade_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_id` int(11) NOT NULL,
  `class_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of grade_report
-- ----------------------------
INSERT INTO `grade_report` VALUES ('1', '3', 'John', 'Mayer', '401', 'Popular Music Institute', '80');
INSERT INTO `grade_report` VALUES ('2', '3', 'John', 'Mayer', '228', 'Survey of Jazz Composition and Arranging', '95');
INSERT INTO `grade_report` VALUES ('3', '1', 'Lang', 'Lang', '101', 'Classic Music Theory', '100');
INSERT INTO `grade_report` VALUES ('4', '1', 'Lang', 'Lang', '401', 'Popular Music Institute', '99');
INSERT INTO `grade_report` VALUES ('5', '1', 'Lang', 'Lang', '228', 'Survey of Jazz Composition and Arranging', '99');
INSERT INTO `grade_report` VALUES ('6', '2', 'Osamuraisan', 'Osamuraisan', '401', 'Popular Music Institute', '77');
INSERT INTO `grade_report` VALUES ('7', '2', 'Osamuraisan', 'Osamuraisan', '228', 'Survey of Jazz Composition and Arranging', '87');
INSERT INTO `grade_report` VALUES ('8', '5', 'Joe', 'Satriani', '101', 'Classic Music Theory', '90');
INSERT INTO `grade_report` VALUES ('9', '5', 'Joe', 'Satriani', '401', 'Popular Music Institute', '93');
INSERT INTO `grade_report` VALUES ('10', '5', 'Joe', 'Satriani', '228', 'Survey of Jazz Composition and Arranging', '82');
INSERT INTO `grade_report` VALUES ('11', '4', 'John', 'Legend', '101', 'Classic Music Theory', '75');
INSERT INTO `grade_report` VALUES ('12', '4', 'John', 'Legend', '401', 'Popular Music Institute', '100');
INSERT INTO `grade_report` VALUES ('13', '4', 'John', 'Legend', '228', 'Survey of Jazz Composition and Arranging', '88');

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int(11) DEFAULT NULL,
  `avatar_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO `students` VALUES ('1', 'Lang', 'Lang', 37, 'https://images.sk-static.com/images/media/img/col6/20141014-163753-462528.png');
INSERT INTO `students` VALUES ('2', 'Osamuraisan', 'Osamuraisan', 30, 'https://f2cdn.mymusicsheet.com/profile/de3b194b-c569-48af-a94d-782b5ee355e6-1558117157.jpg');
INSERT INTO `students` VALUES ('3', 'John', 'Mayer', 42, 'https://dmn-dallas-news-prod.cdn.arcpublishing.com/resizer/5jVqYxtuuZqn7ZZiVtwsHPPU64o=/1660x934/smart/filters:no_upscale()/guidelive-pegasus.imgix.net/img/photos/2017/02/24/John_Mayer.jpg');
INSERT INTO `students` VALUES ('4', 'John', 'Legend', 41, 'http://theridlermobiledj.co.nz/wp-content/uploads/2014/02/John-Legend-All-Of-Me-500x410.jpg');
INSERT INTO `students` VALUES ('5', 'Joe', 'Satriani', 63, 'https://images.sk-static.com/images/media/img/col6/20181220-082020-838885.jpg');
