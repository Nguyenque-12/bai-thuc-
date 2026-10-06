CREATE DATABASE IF NOT EXISTS payflow_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE payflow_db;

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15, 2),
    transaction_type VARCHAR(20), -- 'DEPOSIT', 'WITHDRAW', 'TRANSFER'
    created_at DATETIME
);

CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';