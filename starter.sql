-- CS340 Group 29, DDL and DML queries
-- Author: Xiaoshi Zeng, Xinpeng Liu
-- MySQL dump 10.16  Distrib 10.1.37-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database:
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- 1. Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `studentFirstName` varchar(255) NOT NULL,
  `studentLastName` varchar(255) NOT NULL,
  `studentAge` int(11),
  `studentAvatarLink` varchar(255) DEFAULT 'NONE',
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--
-- helper to delete data
--DELETE FROM `Students`;
LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students`
(studentID, studentFirstName, studentLastName, studentAge, studentAvatarLink)
VALUES
(1,'Lang', 'Lang', 37, 'https://images.sk-static.com/images/media/img/col6/20141014-163753-462528.png'),
(2, 'Osamuraisan', 'Osamuraisan', 30, 'https://f2cdn.mymusicsheet.com/profile/de3b194b-c569-48af-a94d-782b5ee355e6-1558117157.jpg'),
(3, 'John', 'Mayer', 42, 'https://dmn-dallas-news-prod.cdn.arcpublishing.com/resizer/5jVqYxtuuZqn7ZZiVtwsHPPU64o=/1660x934/smart/filters:no_upscale()/guidelive-pegasus.imgix.net/img/photos/2017/02/24/John_Mayer.jpg'),
(4, 'John', 'Legend', 41, 'http://theridlermobiledj.co.nz/wp-content/uploads/2014/02/John-Legend-All-Of-Me-500x410.jpg'),
(5, 'Joe', 'Satriani', 63, 'https://images.sk-static.com/images/media/img/col6/20181220-082020-838885.jpg');
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- 2. Table structure for table `Classes`
--

DROP TABLE IF EXISTS `Classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Classes` (
  `classID` int(11) NOT NULL,
  `className` varchar(255) NOT NULL,
  `classDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Classes`
--
--DELETE FROM `Classes`;

LOCK TABLES `Classes` WRITE;
/*!40000 ALTER TABLE `Classes` DISABLE KEYS */;
INSERT INTO `Classes`
VALUES
(101, 'Classic Music Theory', 'This course introduces students to diatonic harmonic analysis in various musical textures, melody writing, and harmonization of melodies in various musical textures.'),
(228, 'Survey of Jazz Composition and Arranging', 'A comprehensive study of the evolution of jazz arranging and composition from the 1920s to the present.'),
(401, 'Popular Music Institute', 'This experiential course provides students with the practical and analytical skills needed to develop a successful touring act chosen from among their fellow students.');
/*!40000 ALTER TABLE `Classes` ENABLE KEYS */;
UNLOCK TABLES;


--
-- 3. Table structure for table `Enrollments`
--

DROP TABLE IF EXISTS `Enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Enrollments` (
  `enrollmentId` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` int(11) NOT NULL,
  `classId` int(11) NOT NULL,
  PRIMARY KEY (`enrollmentId`),
  KEY `studentId` (`studentId`),
  KEY `classId` (`classId`),
  CONSTRAINT `Enrollments_ibfk_1` FOREIGN KEY (`studentId`) REFERENCES `Students` (`studentID`),
  CONSTRAINT `Enrollments_ibfk_2` FOREIGN KEY (`classId`) REFERENCES `Classes` (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enrollments`
--Helper to delete data
--DELETE FROM Enrollments;

LOCK TABLES `Enrollments` WRITE;
/*!40000 ALTER TABLE `Enrollments` DISABLE KEYS */;
INSERT INTO `Enrollments` VALUES
(1, 2, 228),
(2, 2, 401),
(3, 1, 228),
(4, 1, 101),
(5, 1, 401),
(6, 5, 101),
(7, 5, 401),
(8, 4, 101),
(9, 4, 228),
(10, 4, 401),
(11, 3, 401),
(12, 3, 228);
/*!40000 ALTER TABLE `Enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- 4. Table structure for table `Grade_report`
--

DROP TABLE IF EXISTS `Grade_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Grade_report` (
  `transcriptId` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) NOT NULL,
  `studentFirstName` varchar(255) NOT NULL,
  `studentLastName` varchar(255) NOT NULL,
  `classId` int(11) NOT NULL,
  `className` varchar(255) NOT NULL,
  `grade` float NOT NULL,
  PRIMARY KEY (`transcriptId`),
  KEY `studentid` (`studentid`),
  KEY  `classId` (`classId`),
  CONSTRAINT `Grade_report_ibfk_1` FOREIGN KEY (`studentid`) REFERENCES `Students` (`studentID`),
  CONSTRAINT `Grade_report_ibfk_2` FOREIGN KEY (`classId`) REFERENCES `Classes` (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Grade_report`
--
-- helper to delete data
--DELETE FROM `Grade_report`;

LOCK TABLES `Grade_report` WRITE;
/*!40000 ALTER TABLE `Grade_report` DISABLE KEYS */;
INSERT INTO `Grade_report` VALUES
(1, 3, 'John', 'Mayer', 401, 'Popular Music Institute', 80),
(2, 3, 'John', 'Mayer', 228, 'Survey of Jazz Composition and Arranging', 95),
(3, 1, 'Lang', 'Lang', 101, 'Classic Music Theory', 100),
(4, 1, 'Lang', 'Lang', 401, 'Popular Music Institute', 99),
(5, 1, 'Lang', 'Lang', 228, 'Survey of Jazz Composition and Arranging', 99),
(6, 2, 'Osamuraisan', 'Osamuraisan', 401, 'Popular Music Institute', 77),
(7, 2, 'Osamuraisan', 'Osamuraisan', 228, 'Survey of Jazz Composition and Arranging', 87),
(8, 5, 'Joe', 'Satriani', 101, 'Classic Music Theory', 90),
(9, 5, 'Joe', 'Satriani', 401, 'Popular Music Institute', 93),
(10, 5, 'Joe', 'Satriani', 228, 'Survey of Jazz Composition and Arranging', 82),
(11, 4, 'John', 'Legend', 101, 'Classic Music Theory', 75),
(12, 4, 'John', 'Legend', 401, 'Popular Music Institute', 100),
(13, 4, 'John', 'Legend', 228, 'Survey of Jazz Composition and Arranging', 88);
/*!40000 ALTER TABLE `Grade_report` ENABLE KEYS */;
UNLOCK TABLES;