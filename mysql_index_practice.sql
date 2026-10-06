-- ============================================================
-- CSDL CLASSICMODELS - THỰC HÀNH CHỈ MỤC (INDEX) TRONG MYSQL
-- ============================================================

USE classicmodels;

-- ------------------------------------------------------------
-- BƯỚC 1: KIỂM TRA HIỆU NĂNG TRUY VẤN KHI CHƯA ĐÁNH INDEX
-- ------------------------------------------------------------
-- Khi chưa tạo Index, MySQL phải dùng Full Table Scan (type = ALL)
-- và quét qua tất cả các hàng trong bảng để tìm kết quả.
EXPLAIN SELECT * 
FROM customers 
WHERE customerName = 'Land of Toys Inc.';


-- ------------------------------------------------------------
-- BƯỚC 2: TẠO CHỈ MỤC ĐƠN (SINGLE-COLUMN INDEX)
-- ------------------------------------------------------------
-- Tạo Index cho cột customerName
ALTER TABLE customers 
ADD INDEX idx_customerName(customerName);

-- Kiểm tra lại kế hoạch thực thi (Execution Plan)
-- Kết quả thu được: type chuyển từ ALL -> ref, số dòng (rows) giảm xuống còn 1.
EXPLAIN SELECT * 
FROM customers 
WHERE customerName = 'Land of Toys Inc.';


-- ------------------------------------------------------------
-- BƯỚC 3: TẠO CHỈ MỤC PHỨC HỢP (COMPOSITE INDEX)
-- ------------------------------------------------------------
-- Đánh Index kết hợp cho cặp cột (contactFirstName, contactLastName)
ALTER TABLE customers 
ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiểm tra kế hoạch thực thi khi tìm kiếm theo các trường liên hệ
EXPLAIN SELECT * 
FROM customers 
WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';


-- ------------------------------------------------------------
-- BƯỚC 4: XÓA CHỈ MỤC (DROP INDEX)
-- ------------------------------------------------------------
-- Xóa chỉ mục idx_full_name khỏi bảng customers
ALTER TABLE customers 
DROP INDEX idx_full_name;

-- (Tùy chọn) Xóa chỉ mục đơn idx_customerName nếu muốn đưa bảng về trạng thái ban đầu
-- ALTER TABLE customers DROP INDEX idx_customerName;