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
-- Table structure for table `account_history`
--

DROP TABLE IF EXISTS `account_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_history` (
  `id_a_h` int NOT NULL AUTO_INCREMENT,
  `old_balance` double NOT NULL,
  `new_balance` double NOT NULL,
  `datetime_of_new_balance` datetime NOT NULL,
  `reason` varchar(200) NOT NULL,
  `id_a` int NOT NULL,
  PRIMARY KEY (`id_a_h`),
  UNIQUE KEY `id_a_h_UNIQUE` (`id_a_h`),
  KEY `id_a_idx` (`id_a`),
  CONSTRAINT `id_a` FOREIGN KEY (`id_a`) REFERENCES `bank_account` (`id_a`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_history`
--

LOCK TABLES `account_history` WRITE;
/*!40000 ALTER TABLE `account_history` DISABLE KEYS */;
INSERT INTO `account_history` VALUES (3,0,200,'2022-01-01 00:00:00','deposit',6),(4,1000,0,'2020-03-16 00:00:00','transact',9),(5,0,1,'2020-03-17 00:00:00','transact',8),(6,878,870,'2022-12-07 00:00:00','withdrawal',1),(7,870,900,'2022-12-07 00:00:00','deposit',1),(32,1,0,'2022-12-01 00:00:00','withdrawal',6),(38,900,901,'2022-12-13 00:00:00','deposit',1),(39,800,700,'2022-12-13 19:55:53','transact',3),(40,1087,1187,'2022-12-13 19:55:53','transact',7),(41,3200,3100,'2022-12-13 20:11:56','transact',2),(42,12,13,'2022-12-13 20:11:56','transact',8),(43,2900,2800,'2022-12-13 20:18:23','transact',2),(44,15,16,'2022-12-13 20:18:23','transact',8),(45,2700,2600,'2022-12-13 20:22:20','transact',2),(46,17,18,'2022-12-13 20:22:20','transact',8),(47,2500,2400,'2022-12-13 20:25:51','transact',2),(48,19,20,'2022-12-13 20:25:51','transact',8),(49,2300,2200,'2022-12-13 20:27:37','transact',2),(50,21,21,'2022-12-13 20:27:37','transact',8),(51,2200,2100,'2022-12-13 20:28:13','transact',2),(52,21,22,'2022-12-13 20:28:13','transact',8),(53,900,899,'2022-12-13 20:57:41','transact',1),(54,2100,2205,'2022-12-13 20:57:41','transact',2),(55,899,898,'2022-12-13 21:09:42','transact',1),(56,2205,2310,'2022-12-13 21:09:42','transact',2),(57,898,897,'2022-12-13 21:10:16','transact',1),(58,2310,2415,'2022-12-13 21:10:16','transact',2),(59,897,896,'2022-12-13 21:11:57','transact',1),(60,2415,2520,'2022-12-13 21:11:57','transact',2),(61,896,894,'2022-12-13 21:12:03','transact',1),(62,2520,2730,'2022-12-13 21:12:03','transact',2),(63,2730,2530,'2022-12-13 23:02:45','transact',2),(64,0,200,'2022-12-13 23:02:45','transact',102),(65,200,0,'2022-12-13 23:03:21','transact',102),(66,2530,2730,'2022-12-13 23:03:21','transact',2),(67,894,893,'2022-12-13 23:03:41','transact',1),(68,2730,2835,'2022-12-13 23:03:41','transact',2),(69,2835,2635,'2022-12-13 23:04:09','transact',2),(70,2835,3035,'2022-12-13 23:04:09','transact',2),(71,3035,2935,'2022-12-13 23:06:01','transact',2),(72,3035,3135,'2022-12-13 23:06:01','transact',2),(73,893,892,'2022-12-14 17:09:18','transact',1),(74,3135,3240,'2022-12-14 17:09:18','transact',2),(75,892,890,'2022-12-21 13:28:10','transact',1),(76,3240,3450,'2022-12-21 13:28:10','transact',2);
/*!40000 ALTER TABLE `account_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07  0:34:03
