-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `id_a` int NOT NULL AUTO_INCREMENT,
  `number` char(12) NOT NULL,
  `currency` varchar(20) DEFAULT NULL,
  `balance` float DEFAULT '0',
  `datetime_of_balance` datetime DEFAULT NULL,
  `id_c` int DEFAULT NULL,
  PRIMARY KEY (`id_a`),
  UNIQUE KEY `numberl_UNIQUE` (`number`),
  UNIQUE KEY `id_a_UNIQUE` (`id_a`),
  KEY `id_c_idx` (`id_c`),
  CONSTRAINT `id_c` FOREIGN KEY (`id_c`) REFERENCES `client` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_account`
--

LOCK TABLES `bank_account` WRITE;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` VALUES (1,'000000000001','dollar',890,'2022-12-21 13:28:10',1),(2,'000000000002','ruble',3450,'2022-12-21 13:28:10',1),(3,'000011000000','ruble',600,'2022-12-13 19:55:53',6),(4,'010099900000','ruble',1334,'2022-12-13 19:20:28',6),(6,'000100000003','yuan',200,'2019-02-12 00:00:00',2),(7,'000000200004','ruble',1287,'2022-12-13 19:55:53',3),(8,'000000000005','kerm',22,'2022-12-13 20:28:13',4),(9,'000000000006','dollar',0,'2022-01-12 00:00:00',3),(10,'000000000000','ruble',0,'1970-01-01 00:00:00',NULL),(102,'010099900002','ruble',0,'2022-12-13 23:03:21',1),(103,'010099900003','ruble',0,'2022-12-14 17:09:37',1);
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07  0:34:04
