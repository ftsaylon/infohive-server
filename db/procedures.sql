-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: dabar
-- ------------------------------------------------------
-- Server version	5.7.22

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
-- Dumping routines for database 'dabar'
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS dabar_cart_buyProduct;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_buyProduct`(guser_id INT(11), gproduct_id INT(11))
BEGIN
    CALL dabar_cart_getId(guser_id, @gcart_id);
    SET @toBuy := (SELECT quantity FROM cart_product WHERE cart_id=@gcart_id AND product_id=gproduct_id);
    UPDATE product SET stock=stock-@toBuy WHERE id=gproduct_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_cart_checkout;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_checkout`(guser_id INT(11))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;

  CALL dabar_cart_getId(guser_id, @gcart_id);
  IF (SELECT forapproval from cart where id = @gcart_id) = 0 THEN
    SIGNAL SQLSTATE '45000';
  END IF;
  UPDATE cart SET date=CURRENT_TIMESTAMP, checkedout=1 WHERE id = @gcart_id;

  INSERT INTO cart(user_id) VALUES (guser_id);

  COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_cart_delProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_delProduct`(guser_id INT(11), gproduct_id INT(11))
BEGIN
  CALL dabar_cart_getId(guser_id, @gcart_id);
  DELETE FROM cart_product WHERE cart_id=@gcart_id AND product_id=gproduct_id;
  CALL dabar_cart_updateTotal(@gcart_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_cart_getId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_getId`(guser_id INT(11), OUT cartId INT(11))
BEGIN
  SELECT id FROM cart WHERE user_id=guser_id AND checkedout=0 INTO cartId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_cart_incQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_incQuantity`(guser_id INT(11), gproduct_id INT(11), gincrease INT(24))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;

  CALL dabar_cart_getId(guser_id, @gcart_id);
  UPDATE cart_product SET quantity=quantity+gincrease WHERE cart_id=@gcart_id AND product_id=gproduct_id;
  CALL dabar_cart_updateTotal(@gcart_id);
  COMMIT;
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_cart_isEnough;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_isEnough`(guser_id INT(11))
BEGIN
  SELECT IF(0 in (SELECT IF(a.rem<0, 0, 1) FROM (SELECT product.stock-quantity AS rem from cart_product,product where cart_product.product_id=product.id and cart_id=@gcart_id) a), 0, 1) AS isEnough;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_cart_putProductToCart;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_putProductToCart`(guser_id INT(11), gproduct_id INT(11), gquantity INT(24))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;

  CALL dabar_cart_getId(guser_id, @gcart_id);
  SET @currentPrice := (SELECT price FROM product WHERE id=gproduct_id);
  SET @onApproval := (SELECT forapproval FROM cart WHERE id=@gcart_id);
  INSERT INTO cart_product(cart_id, product_id, quantity, price) SELECT @gcart_id, gproduct_id, gquantity, @currentPrice WHERE @onApproval=0;
  CALL dabar_cart_updateTotal(@gcart_id);
  SELECT @onApproval;

  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_cart_showProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_cart_showProducts;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_showProducts`(guser_id INT(11))
BEGIN
  CALL dabar_cart_getId(guser_id, @gcart_id);
  SELECT product_id, name, stock, cart_product.quantity, cart_product.price, cart_product.price*cart_product.quantity AS total FROM cart_product, product WHERE product.id = cart_product.product_id AND cart_id=@gcart_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_cart_updateTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_cart_updateTotal;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_cart_updateTotal`(gcart_id INT(11))
BEGIN
  SET @total_null := (SELECT SUM(quantity*price) FROM cart_product WHERE cart_id = gcart_id);
  SET @total_num := (SELECT IF(@total_null IS NULL, 0, @total_null));
  UPDATE cart SET total=@total_num WHERE id=gcart_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_pricechange_insertOne` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_pricechange_insertOne;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_pricechange_insertOne`(gproduct_id INT(11), gprice FLOAT)
BEGIN
  SET @old := (SELECT price FROM product WHERE id=gproduct_id);
  SET @didChange := (SELECT IF(@old=gprice, 0, 1));
  INSERT INTO pricechange(date, product_id, price) SELECT CURRENT_TIMESTAMP, gproduct_id, gprice WHERE @didChange=1;
  UPDATE cart_product SET price=gprice
    WHERE
       product_id=gproduct_id AND
       cart_id IN 
        (SELECT id FROM cart WHERE id IN 
          (SELECT cart_id FROM (SELECT * FROM cart_product) AS something WHERE product_id=gproduct_id) 
          AND checkedout=0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_product_setStock;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_product_setStock`(gproduct_id INT(11), newstocks INT(10), stockschange INT(10))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;
  START TRANSACTION;
  UPDATE product SET stock=newstocks WHERE id=gproduct_id;
  INSERT INTO stocklog(product_id, stocks_left, stocks_changed) VALUES (gproduct_id, newstocks, stockschange);
  COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_user_getId;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_user_getId`(gemail VARCHAR(256))
BEGIN
  SELECT id FROM user WHERE email=gemail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_user_insertOne` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_user_insertOne;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_user_insertOne`(gemail VARCHAR(256))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;
  
  INSERT INTO user SET email=gemail;
  SET @customerId_weak := (SELECT id FROM user WHERE email=gemail);
  SET @customerId_last := (SELECT LAST_INSERT_ID());
  INSERT INTO cart(user_id) SELECT @customerId_weak where @customerId_weak = @customerId_last;
  COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_user_isAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_user_isAdmin;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_user_isAdmin`(guser_id INT(11))
BEGIN
  SELECT is_admin FROM user WHERE id=guser_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dabar_user_setAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS dabar_user_setAdmin;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_user_setAdmin`(guser_id INT(11), gprivileges TINYINT(1))
BEGIN
  UPDATE user SET is_admin=gprivileges WHERE id=guser_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `salesreport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;

DROP PROCEDURE IF EXISTS salesreport;
CREATE DEFINER=`root`@`localhost` PROCEDURE `salesreport`(gstart DATE, gend DATE)
BEGIN
  SELECT 
    cart_product.product_id, 
    product.name AS productName,
    product.distributorId AS distributorId,
    distributor.name AS distributorName,
    sum(cart_product.quantity * product.price ) AS totalSales, 
    sum(cart_product.quantity) AS totalQuantity
  FROM 
    product, 
    cart_product, 
    cart,
    distributor 
  WHERE 
    product.id = cart_product.product_id AND
    cart_product.cart_id = cart.id AND 
    checkedout=1 AND
    cart.date>=gstart AND cart.date<gend AND
    distributor.id = product.distributorId
  GROUP BY 
    cart_product.product_id
  ORDER BY 
    product.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-05 15:43:47

-- get_first_transaction
DELIMITER ;;

DROP PROCEDURE IF EXISTS get_first_transaction;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_first_transaction`()
BEGIN 
  SELECT
    cart.date 
  FROM
    cart 
  WHERE
    checkedout=1
  ORDER BY
    cart.date ASC 
  LIMIT 
    1;
END ;;
DELIMITER ;

-- get_latest_transaction

DELIMITER ;;
DROP PROCEDURE IF EXISTS get_latest_transaction;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_latest_transaction`()
BEGIN
  SELECT
    cart.date 
  FROM
    cart 
  WHERE
    checkedout=1
  ORDER BY
    cart.date DESC
  LIMIT 
    1;
END ;;
DELIMITER GO

-- insert product
DROP PROCEDURE IF EXISTS dabar_product_insertOne;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_product_insertOne`
(
  category_insert int(11),
  name_insert varchar(256),
  description_insert text,
  distributorId_insert int(11),
  contactId_insert int(11),
  price_insert float,
  stock_insert int(10),
  size_insert varchar(128),
  imageUrl_insert varchar(1024),
  siteUrl_insert varchar(1024)
)  
BEGIN 
  INSERT INTO product(category_id, name, description, distributorId, contactId, price, stock, size, imageUrl, siteUrl, created, updated) VALUES 
  (
    category_insert,
    name_insert,
    description_insert,
    distributorId_insert,
    contactId_insert,
    price_insert,
    stock_insert,
    size_insert,
    imageUrl_insert,
    siteUrl_insert,
    CURDATE(),
    CURDATE()
  );

  SET @last_inserted_id_product := (SELECT LAST_INSERT_ID());
  INSERT INTO stocklog(product_id, stocks_left, stocks_changed) VALUES (@last_inserted_id_product, stock_insert, stock_insert);
  INSERT INTO pricechange values(NULL,CURDATE(),@last_inserted_id_product,price_insert);
END;
  
GO

DROP PROCEDURE IF EXISTS dabar_product_updateOne;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dabar_product_updateOne`
(
  category_insert int(11),
  name_insert varchar(256),
  description_insert text,
  distributorId_insert int(11),
  contactId_insert int(11),
  price_insert float,
  size_insert varchar(128),
  imageUrl_insert varchar(1024),
  siteUrl_insert varchar(1024),
  product_id_insert int(11)
)  
BEGIN 
  IF price_insert != (SELECT price from product where id = product_id_insert) THEN
    CALL dabar_pricechange_insertOne (product_id_insert,price_insert);
  END IF;
  UPDATE product
  SET
    category_id = category_insert,
    name = name_insert,
    description = description_insert,
    distributorId = distributorId_insert,
    contactId = contactId_insert,
    price = price_insert,
    size = size_insert,
    imageUrl = imageUrl_insert,
    siteUrl = siteUrl_insert,
    updated = CURDATE()
    WHERE id = product_id_insert;
END;
  GO

DELIMITER //

DROP PROCEDURE IF EXISTS dabar_cart_getOrders;
CREATE DEFINER=`root`@`localhost` PROCEDURE dabar_cart_getOrders
(guser_id INT(11))
BEGIN
  SELECT id,total,date FROM cart WHERE user_id=guser_id and checkedout=1;
END //

DROP PROCEDURE IF EXISTS dabar_cart_selectOne;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_cart_selectOne
(gcart_id INT(11))
BEGIN
  SELECT 
    product_id,
    product.name AS product_name,
    distributor.name AS distributor_name, 
    cart_product.quantity AS quantity, 
    cart_product.price AS price, 
    cart_product.price*cart_product.quantity AS total 
  FROM
    cart_product, 
    product, 
    distributor 
  WHERE 
    product.id = cart_product.product_id AND 
    cart_id=gcart_id AND
    distributor.id = cart_product.product_id;
END //

DROP PROCEDURE IF EXISTS dabar_pricechange_selectAll;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_pricechange_selectAll
()
BEGIN
  SELECT product.name, pricechange.* FROM pricechange, product WHERE product.id=pricechange.product_id;
END //

DROP PROCEDURE IF EXISTS dabar_stocklog_selectAll;
CREATE PROCEDURE dabar_stocklog_selectAll
()
BEGIN
  SELECT product.name, stocklog.* FROM stocklog, product WHERE stocklog.product_id=product.id;
END //

DROP PROCEDURE IF EXISTS dabar_distributor_softDeleteOne;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_distributor_softDeleteOne
(gid INT(11))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;

  UPDATE distributor SET deleted=1 WHERE id=gid;
  UPDATE product SET stock=0 WHERE distributorId=gid;

  COMMIT;
END //

DROP PROCEDURE IF EXISTS dabar_cart_getEyes;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_cart_getEyes
(gproduct_id INT(11))
BEGIN
  SELECT COUNT(*) AS potentialBuyers, SUM(quantity) AS stocksInCarts FROM cart, cart_product WHERE checkedout=0 AND cart.id=cart_product.cart_id AND product_id=gproduct_id GROUP BY product_id;
END //

DROP PROCEDURE IF EXISTS dabar_cart_setForApproval;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_cart_setForApproval
(guser_id INT(11), gapproval TINYINT(1))
BEGIN
  CALL dabar_cart_getId(guser_id, @gcart_id);
  SET @isEmptyCart := (SELECT total FROM cart WHERE id=@gcart_id);
  UPDATE cart SET forapproval=gapproval, date=CURRENT_TIMESTAMP WHERE id=@gcart_id AND @isEmptyCart!=0;
  SELECT @isEmptyCart;
END //

DROP PROCEDURE IF EXISTS dabar_cart_getForApprovals;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_cart_getForApprovals
()
BEGIN
  SELECT cart.id, cart.user_id, user.email, cart.total, date FROM cart, user WHERE cart.user_id=user.id AND forapproval=1 AND checkedout=0;
END //

DROP PROCEDURE IF EXISTS dabar_cart_isForApproval;
CREATE DEFINER = `root`@`localhost` PROCEDURE dabar_cart_isForApproval
(guser_id INT(11))
BEGIN
  CALL dabar_cart_getId(guser_id, @gcart_id);
  SELECT forapproval FROM cart WHERE id=@gcart_id;
END //
