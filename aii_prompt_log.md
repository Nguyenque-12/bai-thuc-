# Nhật ký Tương tác AI (AI Prompt Log) - PayFlow Project

## Prompt 1: Tìm hiểu thuật ngữ SARGable và hàm trong WHERE
* **User:** "Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng, nhưng trong mệnh đề WHERE tôi lại viết WHERE YEAR(col) = 2026, tại sao MySQL lại từ chối sử dụng Index và phải quét toàn bộ bảng (Full Table Scan)?"
* **AI:** Giải thích rằng Index B-Tree lưu trữ các giá trị gốc đã sắp xếp. Khi áp dụng hàm `YEAR()` bọc xung quanh cột, MySQL bắt buộc phải thực thi hàm đó trên từng bản ghi của bảng trước khi so sánh, làm vô hiệu hóa khả năng tìm kiếm cây nhị phân (Index Lookup) và buộc phải rơi vào trạng thái Full Table Scan.

## Prompt 2: Thứ tự các cột trong Composite Index
* **User:** "Khi thiết kế một Composite Index trong MySQL cho cột (transaction_type, created_at), thứ tự các cột trong Index có quan trọng không? Tôi nên đặt cột nào đứng trước để có hiệu suất lọc dữ liệu (Selectivity) tốt nhất?"
* **AI:** Phân tích quy tắc **Leftmost Prefix**: Cột thực hiện phép so sánh bằng (`=`) nên được đặt ở vị trí đầu tiên (`transaction_type`), tiếp theo là cột thực hiện phép so sánh khoảng Range (`>=`, `<`) là `created_at`. Điều này giúp MySQL thu hẹp vùng tìm kiếm nhanh nhất trước khi duyệt khoảng ngày.

## Prompt 3: Sự khác biệt giữa các chỉ số Extra trong EXPLAIN
* **User:** "Trong kết quả EXPLAIN, cột 'Extra' hiện chữ 'Using index condition' khác gì với 'Using index' (Covering Index)?"
* **AI:** Giải thích `Using index condition` (ICP - Index Condition Pushdown) có nghĩa là MySQL dùng Index để lọc dữ liệu ở tầng lưu trữ trước khi trả về tầng máy chủ, trong khi `Using index` nghĩa là toàn bộ các cột cần lấy nằm hoàn toàn trong B-Tree Index không cần đọc lại bảng gốc.