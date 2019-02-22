DROP USER IF EXISTS 'dabar';
CREATE USER 'dabar' IDENTIFIED BY 'pwd@dabar33';
DROP DATABASE IF EXISTS `dabar`;
CREATE DATABASE `dabar`;
GRANT SUPER ON *.* TO 'dabar';
GRANT ALL PRIVILEGES ON dabar.* TO 'dabar' WITH GRANT OPTION;

USE `dabar`;

DROP TABLE IF EXISTS stocklog;
CREATE TABLE stocklog (
  id INT(11) NOT NULL AUTO_INCREMENT,
  product_id INT(11) NOT NULL,
  date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  stocks_left INT(10) NULL DEFAULT NULL,
  stocks_changed INT(10) NULL DEFAULT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY(`product_id`)
    REFERENCES product(`id`)
    ON DELETE NO ACTION
);

DELIMITER //
DROP PROCEDURE IF EXISTS dabar_cart_checkout;
CREATE PROCEDURE dabar_cart_checkout
(guser_id INT(11))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;

  START TRANSACTION;

  CALL dabar_cart_getId(guser_id, @gcart_id);
  
  UPDATE cart SET date=CURRENT_TIMESTAMP, checkedout=1 WHERE id = @gcart_id;

  INSERT INTO cart(user_id) VALUES (guser_id);

END //

DROP PROCEDURE IF EXISTS dabar_cart_isEnough;
CREATE PROCEDURE dabar_cart_isEnough
(guser_id INT(11))
BEGIN
  SELECT IF(0 in (SELECT IF(a.rem<0, 0, 1) FROM (SELECT product.stock-quantity AS rem from cart_product,product where cart_product.product_id=product.id and cart_id=@gcart_id) a), 0, 1) AS isEnough;
END //

DROP PROCEDURE IF EXISTS dabar_cart_buyProduct;
CREATE PROCEDURE dabar_cart_buyProduct
(guser_id INT(11), gproduct_id INT(11))
BEGIN
    CALL dabar_cart_getId(guser_id, @gcart_id);
    SET @toBuy := (SELECT quantity FROM cart_product WHERE cart_id=@gcart_id AND product_id=gproduct_id);
    UPDATE product SET stock=stock-@toBuy WHERE id=gproduct_id;
END //

DROP PROCEDURE IF EXISTS dabar_product_setStock;
CREATE PROCEDURE dabar_product_setStock
(gproduct_id INT(11), newstocks INT(10), stockschange INT(10))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      ROLLBACK;
      RESIGNAL;
    END;
  START TRANSACTION;
  UPDATE product SET stock=newstocks WHERE id=gproduct_id;
  INSERT INTO stocklog(product_id, stocks_left, stocks_changed) VALUES (gproduct_id, newstocks, stockschange);

END //

DROP PROCEDURE IF EXISTS dabar_cart_getOrders;
CREATE PROCEDURE dabar_cart_getOrders
(guser_id INT(11))
BEGIN
  SELECT id,total,date FROM cart WHERE user_id=guser_id and checkedout=1;
END //

DROP PROCEDURE IF EXISTS dabar_cart_selectOne;
CREATE PROCEDURE dabar_cart_selectOne
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