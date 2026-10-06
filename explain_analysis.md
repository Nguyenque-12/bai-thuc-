# Báo cáo Phân tích Kế hoạch Thực thi EXPLAIN - PayFlow Project

## 1. Phân tích nguyên nhân điểm nghẽn (Legacy Query)
Trong câu lệnh cũ, việc dùng hàm `YEAR(created_at)` và `MONTH(created_at)` khiến truy vấn bị vi phạm nguyên tắc **SARGable** (Search Argument Able). MySQL không thể dùng cấu trúc B-Tree Index để tìm kiếm nhị phân mà phải bọc hàm cho từng dòng trong bảng, dẫn tới:
* `type`: **ALL** (Full Table Scan - Quét toàn bộ bảng).
* `rows`: Quét toàn bộ **5,000,000** bản ghi.
* Tải CPU tăng cao và gây khóa bảng/xung đột tài nguyên.

## 2. Kết quả sau khi Tối ưu hóa (Optimized Query)
Bằng việc tạo Composite Index `idx_type_date (transaction_type, created_at)` và chuyển điều kiện sang dạng khoảng thời gian (Range comparison: `>=` và `<`):
* `type`: Chuyển từ **ALL** $\rightarrow$ **range** (hoặc **ref**).
* `possible_keys` & `key`: Nhận chính xác Index `idx_type_date`.
* `rows`: Số lượng bản ghi phải quét giảm từ **5,000,000** xuống chỉ còn các dòng thỏa mãn trong tháng 6/2026.
* `Extra`: Hiển thị `Using index condition`, loại bỏ hoàn toàn hiện tượng nghẽn mạng và Full Table Scan.