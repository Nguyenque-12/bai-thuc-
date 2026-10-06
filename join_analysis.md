# Giải trình Kỹ thuật SQL - FlashMart Project

Trong báo cáo dành cho Marketing, việc sử dụng `COUNT(o.order_id)` thay vì `COUNT(*)` khi kết hợp với `LEFT JOIN` là điều kiện bắt buộc vì:

1. **Cơ chế xử lý giá trị NULL:**  
   Hàm `COUNT(tên_cột)` chỉ đếm các giá trị không phải NULL (Non-NULL values). Đối với khách hàng chưa mua hàng như Charlie, bảng `Orders` sẽ trả về dòng chứa toàn giá trị NULL. Khi đó, `COUNT(o.order_id)` đếm giá trị NULL và trả về kết quả đúng là **0**.

2. **Lỗi sai lệch của `COUNT(*)`:**  
   Hàm `COUNT(*)` đếm tổng số dòng dữ liệu trả về từ bảng kết quả. Vì `LEFT JOIN` giữ lại bản ghi của Charlie (dạng `[3, 'Charlie', NULL, NULL, NULL]`), `COUNT(*)` sẽ đếm dòng này và trả về kết quả sai là **1**.