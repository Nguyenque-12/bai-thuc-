# Nhật ký Sử dụng AI (AI Prompt Log) - HealthSync Project

## Prompt 1: Tìm hiểu Anti-pattern trong trạng thái lịch hẹn
* **User:** "Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột `is_active` (kiểu TINYINT/BOOLEAN) để theo dõi vòng đời của một Đơn hàng/Lịch hẹn lại là một thiết kế tồi (Anti-pattern)? Tôi nên thay thế bằng cấu trúc nào?"
* **AI:** Giải thích rằng BOOLEAN chỉ đại diện cho 2 trạng thái bật/tắt, không thể mô tả tiến trình tuần tự phức tạp. Khuyên dùng kiểu `ENUM` hoặc tạo bảng riêng `AppointmentStatus` kết nối qua khóa ngoại.

## Prompt 2: Lựa chọn kiểu dữ liệu tài chính
* **User:** "Khi thiết kế cột `deposit_amount` và `penalty_fee` trong MySQL phục vụ tính toán tài chính, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"
* **AI:** Khuyên dùng `DECIMAL(12, 2)` để tránh sai số làm tròn số thực (Floating-point precision errors) của FLOAT/DOUBLE khi thực hiện các phép tính tiền tệ.

## Prompt 3: Cú pháp ENUM trong MySQL
* **User:** "Hãy cho tôi xem cú pháp chuẩn trong MySQL để thêm một cột status với kiểu dữ liệu ENUM chứa các giá trị ('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') vào một bảng có sẵn."
* **AI:** Cung cấp câu lệnh `ALTER TABLE Appointments ADD COLUMN status ENUM(...) DEFAULT 'PENDING';`.