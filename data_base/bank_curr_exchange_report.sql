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
-- Table structure for table `curr_exchange_report`
--

DROP TABLE IF EXISTS `curr_exchange_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curr_exchange_report` (
  `id_c_e_r` int NOT NULL AUTO_INCREMENT,
  `currency1` varchar(50) DEFAULT NULL,
  `currency2` varchar(50) DEFAULT NULL,
  `sum_cur2_to_cur1` double DEFAULT NULL,
  `sum_cur1_to_cur2` double DEFAULT NULL,
  `rep_month` int DEFAULT NULL,
  `rep_year` int DEFAULT NULL,
  PRIMARY KEY (`id_c_e_r`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curr_exchange_report`
--

LOCK TABLES `curr_exchange_report` WRITE;
/*!40000 ALTER TABLE `curr_exchange_report` DISABLE KEYS */;
INSERT INTO `curr_exchange_report` VALUES (80,'kerm','ruble',1.6,1,11,2020),(81,'ruble','kerm',100,16,11,2020),(82,'ruble','ruble',200,200,11,2020),(83,'dollar','ruble',200,0,11,2020),(84,'ruble','dollar',0,1000,11,2020),(85,'ruble','dollar',735,0,12,2022),(86,'dollar','ruble',0,7,12,2022),(87,'kerm','ruble',6,0,12,2022),(88,'ruble','kerm',0,600,12,2022),(89,'ruble','ruble',800,800,12,2022);
/*!40000 ALTER TABLE `curr_exchange_report` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07  0:34:05
