CREATE DATABASE IF NOT EXISTS `demo`;

USE `demo`;

CREATE TABLE IF NOT EXISTS `Student` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `age` INT,
    `country` VARCHAR(50)
);

DESCRIBE `Student`;