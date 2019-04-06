-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: dabar
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

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
-- Dumping data for table `bee`
--

LOCK TABLES `bee` WRITE;
/*!40000 ALTER TABLE `bee` DISABLE KEYS */;
INSERT INTO `bee` VALUES (1,'Honey Bee 1','Test Bee',NULL);
/*!40000 ALTER TABLE `bee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cart_product`
--

LOCK TABLES `cart_product` WRITE;
/*!40000 ALTER TABLE `cart_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Food and Wine',NULL,0),(2,'Beauty',NULL,0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'Aimee Lynn B Dupo','Institute of Biological Sciences, UP Los Banos','Los Baños','Laguna',4030,'09495362893',NULL,'http://uplb.edu.ph','2018-11-14 16:54:31','2018-11-14 16:54:31',0),(2,'Romeo Fenol','Mangas','Alfonso','Cavite',4213,'09164599973',NULL,'https://www.facebook.com/romy.','2018-11-14 16:55:03','2018-11-14 16:55:03',0),(3,'Aldrin Pagcaliwangan','Lipa Beekeepers and Marketers Cooperative, STIARC, Marawoy','Lipa','Batangas',4217,'09193688657',NULL,'','2018-11-14 16:55:53','2018-11-14 16:55:53',0),(4,'Joel Magsaysay','KM 47 ','Silang','Cavite',4118,'00000000000',NULL,'http://www.ilogmaria.com/shop','2018-11-14 16:56:33','2018-11-14 16:56:33',0),(5,'Edelie Omoyon','2259 Topacio St. ','San Juan','Metro Manila',900,'09178888438',NULL,'http://www.milea.ph','2018-11-14 16:57:29','2018-11-14 16:57:29',0),(6,'Romy Kimbungan','AR-48 Riverside, Ambiog','La Trinidad','Benguet',2601,'09106359578',NULL,'','2018-11-14 16:58:00','2018-11-14 16:58:00',0),(7,'Biboy Kurdapio','Umali Subd., College, Laguna','Los Baños','Laguna',4031,'09228493530',NULL,'akosibiboy.ph','2018-11-14 17:02:36','2018-11-14 17:02:36',0);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `distributor`
--

LOCK TABLES `distributor` WRITE;
/*!40000 ALTER TABLE `distributor` DISABLE KEYS */;
INSERT INTO `distributor` VALUES (1,'Aimee Lynn B Dupo','Institute of Biological Sciences, UP Los Banos','Los Baños','Laguna',4030,'09495362893',NULL,'http://uplb.edu.ph','2018-11-14 16:54:31','2018-11-14 16:54:31',0),(2,'Romeo Fenol','Mangas','Alfonso','Cavite',4213,'09164599973',NULL,'https://www.facebook.com/romy.','2018-11-14 16:55:03','2018-11-14 16:55:03',0),(3,'Aldrin Pagcaliwangan','Lipa Beekeepers and Marketers Cooperative, STIARC, Marawoy','Lipa','Batangas',4217,'09193688657',NULL,'','2018-11-14 16:55:53','2018-11-14 16:55:53',0),(4,'Joel Magsaysay','KM 47 ','Silang','Cavite',4118,'00000000000',NULL,'http://www.ilogmaria.com/shop','2018-11-14 16:56:33','2018-11-14 16:56:33',0),(5,'Edelie Omoyon','2259 Topacio St. ','San Juan','Metro Manila',900,'09178888438',NULL,'http://www.milea.ph','2018-11-14 16:57:29','2018-11-14 16:57:29',0),(6,'Romy Kimbungan','AR-48 Riverside, Ambiog','La Trinidad','Benguet',2601,'09106359578',NULL,'','2018-11-14 16:58:00','2018-11-14 16:58:00',0);
/*!40000 ALTER TABLE `distributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `farm`
--

LOCK TABLES `farm` WRITE;
/*!40000 ALTER TABLE `farm` DISABLE KEYS */;
INSERT INTO `farm` VALUES (1,1,100,'Farm 1',14.164849,121.241264,'Bee Farm');
/*!40000 ALTER TABLE `farm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pricechange`
--

LOCK TABLES `pricechange` WRITE;
/*!40000 ALTER TABLE `pricechange` DISABLE KEYS */;
INSERT INTO `pricechange` VALUES (1,'2018-11-14 16:00:00',1,200),(2,'2018-11-14 16:00:00',2,150),(3,'2018-11-14 16:00:00',3,100),(4,'2018-11-14 16:00:00',4,100),(5,'2018-11-14 16:00:00',5,100),(6,'2018-11-14 16:00:00',6,100),(7,'2018-11-14 16:00:00',7,100),(8,'2018-11-14 16:00:00',8,75),(9,'2018-11-14 16:00:00',9,75),(10,'2018-11-14 16:00:00',10,75),(11,'2018-11-14 16:00:00',11,75),(12,'2018-11-14 16:00:00',12,75),(13,'2018-11-14 16:00:00',13,300);
/*!40000 ALTER TABLE `pricechange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,'UPLB Honey','Honey produced by Eropean honey bees,\nApis melliferra, kept in various farm and\nurban environment. Viscous and sweet,\nbest for tea and toast with butter.',1,1,200,10,'300 grams','http://localhost:5000/images/image-1542215316458.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(2,2,'Bee Pampered Virgin Coconut Oil Propolis Soap','Virgin Coconut Oil moisturizes skin and\nhas antioxidant properties while\nPropolis prevents and treats bacterial\nand fungal skin infections.',1,1,150,10,'135 grams','http://localhost:5000/images/image-1542215348003.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(3,2,'Bee Pampered Papaya-Carrot Propolis Soap','Carrot and papaya help keep the skin\nwhite, soft and smooth. Propolis\nprevents and treats bacterial and fungal\nskin infections.',1,1,100,10,'135 grams','http://localhost:5000/images/image-1542215377395.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(4,2,'Bee Pampered Tea Tree Propolis Soap','Clears acne, helping create a naturally\nglowing smooth skin. . Propolis prevents\nand treats bacterial and fungal skin\ninfections',1,1,100,10,'135 grams','http://localhost:5000/images/image-1542215403795.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(5,2,'Bee Pampered Guava-Acapulco Propolis Soap','Guava and Acapulco treat tinea (ring\nworm) infections, eczema scabies,itch\nand insect bites. Propolis prevents and\ntreats bacterial and fungal skin\ninfections.',1,1,100,10,'135 grams','http://localhost:5000/images/image-1542215425508.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(6,2,'Bee Pampered Oatmeal Propolis Soap','Oatmeal moisturizes and exfoliates skin.\nPropolis prevents and treats bacterial\nand fungal skin infections.',1,1,100,10,'135 grams','http://localhost:5000/images/image-1542215447288.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(7,2,'Bee Pampered Co ee Propolis Soap','Coffee is a good antioxidant and\nexfoliant, that helps reduce skin aging.\nPropolis prevents and treats bacterial\nand fungal skin infections.',1,1,100,10,'135 grams','http://localhost:5000/images/image-1542215478048.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(8,2,'Bee Pampered Papaya-Carrot Propolis Soap','Carrot and papaya help keep the skin\nwhite, soft and smooth. Propolis\nprevents and treats bacterial and fungal\nskin infections.',1,1,75,10,'100 grams','http://localhost:5000/images/image-1542215509360.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(9,2,'Bee Pampered Tea Tree Propolis Soap','Clears acne, helping create a naturally\nglowing smooth skin. . Propolis prevents\nand treats bacterial and fungal skin\ninfections.',1,1,75,10,'100 grams','http://localhost:5000/images/image-1542215532892.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(10,2,'Bee Pampered Guava-Acapulco Propolis Soap','Guava and Acapulco treat tinea (ring\nworm) infections, eczema scabies,itch\nand insect bites. Propolis prevents and\ntreats bacterial and fungal skin\ninfections.',1,1,75,10,'100 grams','http://localhost:5000/images/image-1542215563876.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(11,2,'Bee Pampered Oatmeal Propolis Soap','Oatmeal moisturizes and exfoliates skin.\nPropolis prevents and treats bacterial\nand fungal skin infections.',1,1,75,10,'100 grams','http://localhost:5000/images/image-1542215583026.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(12,2,'Bee Pampered Co ee Propolis Soap','Coffee is a good antioxidant and\nexfoliant, that helps reduce skin aging.\nPropolis prevents and treats bacterial\nand fungal skin infections.',1,1,75,10,'100 grams','http://localhost:5000/images/image-1542215604453.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0),(13,1,'UPLB Honey 2','Food and Wine',1,1,300,10,'500 ml','http://localhost:5000/images/image-1542215653121.jpg','','2018-11-14 16:00:00','2018-11-14 16:00:00',0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stocklog`
--

LOCK TABLES `stocklog` WRITE;
/*!40000 ALTER TABLE `stocklog` DISABLE KEYS */;
INSERT INTO `stocklog` VALUES (1,1,'2018-11-14 17:08:37',10,10),(2,2,'2018-11-14 17:09:08',10,10),(3,3,'2018-11-14 17:09:37',10,10),(4,4,'2018-11-14 17:10:03',10,10),(5,5,'2018-11-14 17:10:25',10,10),(6,6,'2018-11-14 17:10:47',10,10),(7,7,'2018-11-14 17:11:18',10,10),(8,8,'2018-11-14 17:11:49',10,10),(9,9,'2018-11-14 17:12:12',10,10),(10,10,'2018-11-14 17:12:43',10,10),(11,11,'2018-11-14 17:13:03',10,10),(12,12,'2018-11-14 17:13:24',10,10),(13,13,'2018-11-14 17:14:13',10,10);
/*!40000 ALTER TABLE `stocklog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ftsaylon@up.edu.ph',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-27 18:32:55
