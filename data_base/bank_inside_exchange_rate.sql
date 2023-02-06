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
-- Table structure for table `inside_exchange_rate`
--

DROP TABLE IF EXISTS `inside_exchange_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inside_exchange_rate` (
  `id_e_r` int NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `currency1` varchar(20) NOT NULL,
  `currency2` varchar(20) NOT NULL,
  `rate` double NOT NULL,
  PRIMARY KEY (`id_e_r`),
  UNIQUE KEY `id_e_r_UNIQUE` (`id_e_r`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inside_exchange_rate`
--

LOCK TABLES `inside_exchange_rate` WRITE;
/*!40000 ALTER TABLE `inside_exchange_rate` DISABLE KEYS */;
INSERT INTO `inside_exchange_rate` VALUES (1,'2022-12-21 03:00:21','ruble','ruble',1),(2,'2022-03-07 00:00:00','ruble','dollar',0.02),(3,'2022-03-16 00:00:00','ruble','yuan',20000),(4,'2022-03-12 00:00:00','ruble','kerm',0.01),(5,'2022-12-07 00:00:00','dollar','ruble',105),(6,'2022-12-07 00:00:00','yuan','ruble',0.00009999999747378752),(7,'2022-12-07 00:00:00','kerm','ruble',100),(8,'2022-12-07 00:00:00','dollar','kerm',1),(9,'2022-12-07 00:00:00','dollar','yuan',0.00001),(10,'2022-12-07 00:00:00','kerm','dollar',1),(11,'2022-12-07 00:00:00','kerm','yuan',0.00002),(12,'2022-12-07 00:00:00','yuan','dollar',200000),(13,'2022-12-07 00:00:00','yuan','kerm',300000),(14,'2022-12-07 00:00:00','dollar','dollar',1),(15,'2022-12-07 00:00:00','kerm','kerm',1),(16,'2022-12-07 00:00:00','yuan','yuan',1);
/*!40000 ALTER TABLE `inside_exchange_rate` ENABLE KEYS */;
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
