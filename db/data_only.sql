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
INSERT INTO `bee` VALUES (1,'Honey Bee 1','Test Bee',NULL),(2,'Civet (unidentified)','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','http://dummyimage.com/214x246.jpg/dddddd/000000'),(3,'Red-billed hornbill','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.','http://dummyimage.com/136x179.jpg/5fa2dd/ffffff'),(4,'Springhare','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','http://dummyimage.com/148x197.bmp/dddddd/000000'),(5,'Egret, snowy','In congue. Etiam justo. Etiam pretium iaculis justo.','http://dummyimage.com/179x209.bmp/5fa2dd/ffffff'),(6,'Brazilian tapir','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.\n\nInteger tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.','http://dummyimage.com/118x151.bmp/ff4444/ffffff'),(7,'Fox, silver-backed','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.','http://dummyimage.com/131x145.png/ff4444/ffffff'),(8,'Red lava crab','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','http://dummyimage.com/220x242.bmp/ff4444/ffffff'),(9,'Black-throated cardinal','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\n\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.','http://dummyimage.com/101x113.bmp/5fa2dd/ffffff'),(10,'Antelope, four-horned','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.','http://dummyimage.com/118x223.jpg/cc0000/ffffff'),(11,'Bushbaby, large-eared','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\n\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','http://dummyimage.com/250x155.bmp/cc0000/ffffff');
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
INSERT INTO `farm` VALUES (1,1,100,'Farm 1','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel a',14.164849,121.241264,'Bee Farm');
/*!40000 ALTER TABLE `farm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `farm_bee`
--

LOCK TABLES `farm_bee` WRITE;
/*!40000 ALTER TABLE `farm_bee` DISABLE KEYS */;
INSERT INTO `farm_bee` VALUES (1,1),(1,2),(1,3),(1,4);
/*!40000 ALTER TABLE `farm_bee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `farm_product`
--

LOCK TABLES `farm_product` WRITE;
/*!40000 ALTER TABLE `farm_product` DISABLE KEYS */;
INSERT INTO `farm_product` VALUES (1,3,NULL,NULL),(1,4,NULL,NULL),(1,7,NULL,NULL);
/*!40000 ALTER TABLE `farm_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (16,1,'Future-proofed human-resource algorithm','In congue. Etiam justo. Etiam pretium iaculis justo.\n\nIn hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.','2019-04-21 18:19:23','Ddene'),(17,1,'Balanced discrete benchmark','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.','2019-04-21 18:19:23','Hagan'),(18,1,'Focused disintermediate approach','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.','2019-04-21 18:19:23','Thor'),(19,1,'Triple-buffered eco-centric strategy','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\n\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.','2019-04-21 18:19:23','Leupold'),(20,1,'Synchronised explicit pricing structure','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.\n\nCras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.\n\nQuisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.','2019-04-21 18:19:23','Von'),(21,1,'Re-engineered national methodology','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.\n\nDonec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\n\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','2019-04-21 18:19:23','Ingeberg'),(22,1,'Versatile client-driven infrastructure','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.','2019-04-21 18:19:23','Janet'),(23,1,'Expanded responsive access','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','2019-04-21 18:19:23','Clareta'),(24,1,'Managed stable structure','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.\n\nSuspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','2019-04-21 18:19:23','Erena'),(25,1,'Programmable radical parallelism','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\n\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.','2019-04-21 18:19:23','Victoria');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `news_comment`
--

LOCK TABLES `news_comment` WRITE;
/*!40000 ALTER TABLE `news_comment` DISABLE KEYS */;
INSERT INTO `news_comment` VALUES (4,1,'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.','2019-04-21 18:19:23','Klarrisa'),(5,2,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.','2019-04-21 18:19:23','Land'),(6,3,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.','2019-04-21 18:19:23','Fair'),(7,4,'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\n\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','2019-04-21 18:19:23','Sylvan'),(8,5,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\n\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','2019-04-21 18:19:23','Spencer'),(9,6,'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\n\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.','2019-04-21 18:19:23','Kalina'),(10,7,'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','2019-04-21 18:19:23','Percy'),(11,8,'Phasellus in felis. Donec semper sapien a libero. Nam dui.\n\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.\n\nInteger ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','2019-04-21 18:19:24','Talyah'),(12,9,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.','2019-04-21 18:19:24','Kynthia'),(13,10,'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','2019-04-21 18:19:24','Evangelin');
/*!40000 ALTER TABLE `news_comment` ENABLE KEYS */;
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

-- Dump completed on 2019-04-22  2:21:22
