-- 1. Tạo CSDL QuanLyBanHang
CREATE DATABASE IF NOT EXISTS QuanLyBanHang
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE QuanLyBanHang;

-- 2. Tạo bảng Customer (Khách hàng)
CREATE TABLE IF NOT EXISTS Customer (
    cID INT PRIMARY KEY AUTO_INCREMENT,
    cName VARCHAR(100) NOT NULL,
    cAge INT CHECK (cAge > 0)
);

-- 3. Tạo bảng Order (Hóa đơn)
CREATE TABLE IF NOT EXISTS `Order` (
    oID INT PRIMARY KEY AUTO_INCREMENT,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(15, 2) DEFAULT NULL,
    FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE CASCADE
);

-- 4. Tạo bảng Product (Sản phẩm)
CREATE TABLE IF NOT EXISTS Product (
    pID INT PRIMARY KEY AUTO_INCREMENT,
    pName VARCHAR(150) NOT NULL,
    pPrice DECIMAL(12, 2) NOT NULL CHECK (pPrice >= 0)
);

-- 5. Tạo bảng OrderDetail (Chi tiết hóa đơn - Bảng trung gian n-m)
CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT,
    pID INT,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID) ON DELETE CASCADE,
    FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE CASCADE
);