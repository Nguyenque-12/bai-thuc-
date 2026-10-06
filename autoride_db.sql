CREATE DATABASE IF NOT EXISTS autoride_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE autoride_db;

CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'BOOKED',
    
    security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    late_fee DECIMAL(12, 2) DEFAULT 0.00,
    damage_fee DECIMAL(12, 2) DEFAULT 0.00,
    
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);
INSERT INTO Cars (model_name, license_plate) VALUES 
('Toyota Camry 2024', '30H-123.45'),
('Mazda CX-5 2023', '30K-999.88');

INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit) 
VALUES (1, 'Nguyen Van A', '2026-10-01 08:00:00', 'ACTIVE', 10000000.00);

INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (1, '2026-10-05 17:00:00', 'Xe bị vỡ đèn pha phía trước bên trái, trầy nhẹ cản trước', 'Tran Van Inspector');

UPDATE Rentals 
SET status = 'COMPLETED',
    return_date = '2026-10-05 17:00:00',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

SELECT 
    r.rental_id,
    r.customer_name,
    c.model_name,
    c.license_plate,
    r.status,
    r.security_deposit,
    COALESCE(r.late_fee, 0.00) AS late_fee,
    COALESCE(r.damage_fee, 0.00) AS damage_fee,
    i.damage_description,
    i.inspector_name,
   (r.security_deposit - COALESCE(r.late_fee, 0.00) - COALESCE(r.damage_fee, 0.00)) AS actual_refund_amount
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = 1;