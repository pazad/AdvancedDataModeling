-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cousera-cap
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `addressId` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NOT NULL,
  `zipcode` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`addressId`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`subcategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`subcategory` ;

CREATE TABLE IF NOT EXISTS `mydb`.`subcategory` (
  `subcategoryId` INT NOT NULL,
  `subcategoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`subcategoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `categoryId` INT NOT NULL,
  `categoryName` VARCHAR(45) NOT NULL,
  `subcategoryId` INT NOT NULL,
  PRIMARY KEY (`categoryId`),
  INDEX `FK_subcategory_idx` (`subcategoryId` ASC) VISIBLE,
  CONSTRAINT `FK_subcategory`
    FOREIGN KEY (`subcategoryId`)
    REFERENCES `mydb`.`subcategory` (`subcategoryId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customerId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `contactNumber` INT NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`customerId`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`products` ;

CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `productId` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(45) NOT NULL,
  `productPrice` DECIMAL(10,0) NOT NULL,
  `categoryId` INT NOT NULL,
  PRIMARY KEY (`productId`),
  INDEX `fk_categoryId_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_categoryId`
    FOREIGN KEY (`categoryId`)
    REFERENCES `mydb`.`category` (`categoryId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `orderId` INT NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NOT NULL,
  `productId` INT NOT NULL,
  `quantity` INT NOT NULL,
  `totalCost` DECIMAL(10,0) NOT NULL,
  `customerID` INT NOT NULL,
  `orderPrirority` VARCHAR(45) NOT NULL,
  `discount` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`orderId`),
  INDEX `productId_idx` (`productId` ASC) VISIBLE,
  INDEX `customerId_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `customerId`
    FOREIGN KEY (`customerID`)
    REFERENCES `mydb`.`customers` (`customerId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `productId`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`products` (`productId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`delivery` ;

CREATE TABLE IF NOT EXISTS `mydb`.`delivery` (
  `shipId` INT NOT NULL AUTO_INCREMENT,
  `shipDate` DATE NOT NULL,
  `shipMode` VARCHAR(45) NOT NULL,
  `addressId` INT NOT NULL,
  `orderId` INT NOT NULL,
  `shippingCost` INT NOT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`shipId`),
  INDEX `addressId_idx` (`addressId` ASC) VISIBLE,
  INDEX `orderId_idx` (`orderId` ASC) VISIBLE,
  CONSTRAINT `addressId`
    FOREIGN KEY (`addressId`)
    REFERENCES `mydb`.`address` (`addressId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orderId`
    FOREIGN KEY (`orderId`)
    REFERENCES `mydb`.`orders` (`orderId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
