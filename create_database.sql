-- 1. Tạo CSDL my_database1
CREATE DATABASE IF NOT EXISTS `my_database1`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 2. Kích hoạt CSDL để sử dụng
USE `my_database1`;

-- 3. Tạo một bảng dữ liệu mẫu
CREATE TABLE IF NOT EXISTS `hoc_vien` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `ho_ten` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100)
);

-- 4. Kiểm tra danh sách CSDL
SHOW DATABASES;