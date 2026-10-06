CREATE DATABASE IF NOT EXISTS QuanLyBanHang
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE QuanLyBanHang;

CREATE TABLE IF NOT EXISTS Customer (
    cID INT PRIMARY KEY AUTO_INCREMENT,
    cName VARCHAR(25) NOT NULL,
    cAge TINYINT CHECK (cAge > 0)
);

CREATE TABLE IF NOT EXISTS `Order` (
    oID INT PRIMARY KEY AUTO_INCREMENT,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice INT DEFAULT NULL,
    FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Product (
    pID INT PRIMARY KEY AUTO_INCREMENT,
    pName VARCHAR(25) NOT NULL,
    pPrice INT NOT NULL CHECK (pPrice >= 0)
);

CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID) ON DELETE CASCADE,
    FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE CASCADE
);

INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

SELECT oID, oDate, oTotalPrice
FROM `Order`;

SELECT 
    c.cName AS CustomerName,
    p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

SELECT c.cName
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

SELECT 
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS oTotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;