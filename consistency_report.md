# Báo cáo Phân tích Điểm bất nhất (Consistency Report) - HealthSync

Bản thiết kế cơ sở dữ liệu cũ (Legacy Schema) của hệ thống HealthSync bộc lộ 3 điểm "vênh" nghiêm trọng so với quy trình nghiệp vụ được mô tả trong UML Activity Diagram:

1. **Sai lệch trong quản lý vòng đời lịch hẹn:**  
   Việc sử dụng cột `is_active BOOLEAN` chỉ lưu trữ được hai trạng thái Nhị phân (True/False). Thiết kế này hoàn toàn thất bại khi cần theo dõi một quy trình 5 bước (`PENDING` -> `CONFIRMED` -> `CHECKED_IN` -> `COMPLETED` / `CANCELLED`). Chúng tôi đã thay thế bằng kiểu dữ liệu `ENUM`.

2. **Thiếu hụt dữ liệu tài chính và xử lý phạt hủy cọc:**  
   Thiết kế cũ không có các trường `deposit_amount`, `penalty_fee` và `cancel_reason`. Khi bệnh nhân hủy lịch sau khi đã xác nhận (`CONFIRMED`), hệ thống không thể tự động tính toán khoản tiền phạt thu từ tiền cọc, gây thất thoát và sai lệch trong đối soát kế toán.

3. **Vắng bóng thực thể Đơn thuốc (`Prescriptions`):**  
   Activity Diagram quy định sau khi khám xong (`COMPLETED`), Bác sĩ phải kê đơn thuốc. Việc thiếu hoàn toàn bảng `Prescriptions` liên kết với `Appointments` làm gián đoạn luồng nghiệp vụ cốt lõi của phòng khám.