CREATE DATABASE IF NOT EXISTS `student-management`;

USE `student-management`;

CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `age` INT,
    `country` VARCHAR(100)
);

DESCRIBE `Class`;
DESCRIBE `Teacher`;