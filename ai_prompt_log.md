# Nhật ký Tương tác AI (AI Prompt Log) - FlashMart Project

## Prompt 1: Tìm hiểu cơ chế mặc định của JOIN
* **User:** "Trong cơ sở dữ liệu MySQL, mặc định từ khóa JOIN (khi không ghi rõ LEFT hay RIGHT) sẽ hoạt động như thế nào? Nó sẽ bỏ qua hay giữ lại các bản ghi không có sự trùng khớp ở cả hai bảng?"
* **AI:** Giải thích từ khóa `JOIN` mặc định là `INNER JOIN`. Nó chỉ giữ lại các dòng có khóa trùng khớp ở cả 2 bảng và tự động loại bỏ các dòng không khớp (bản ghi không có giao dịch).

## Prompt 2: Khác biệt giữa COUNT(*) và COUNT(column) khi LEFT JOIN
* **User:** "Khi tôi sử dụng LEFT JOIN và đếm số lượng đơn hàng bằng hàm COUNT, tôi nên dùng COUNT(*) hay COUNT(tên_cột_khóa_chính_bảng_order)? Sự khác biệt khi kết quả trả về NULL là gì?"
* **AI:** Phân tích `COUNT(*)` đếm số dòng làm cho đối tượng chưa có đơn hàng trả về 1, trong khi `COUNT(order_id)` bỏ qua giá trị NULL và trả về đúng số 0.

## Prompt 3: Hiệu năng của Anti-Join
* **User:** "Hãy phân tích hiệu năng (Performance) của việc dùng LEFT JOIN kết hợp IS NULL so với việc dùng subquery NOT IN khi muốn tìm kiếm các bản ghi không tồn tại trong bảng khác."
* **AI:** Phân tích rằng `LEFT JOIN ... WHERE IS NULL` (Anti-Join) có hiệu năng tốt hơn `NOT IN` trên tập dữ liệu lớn, đặc biệt khi cột liên kết có thể chứa giá trị `NULL`.