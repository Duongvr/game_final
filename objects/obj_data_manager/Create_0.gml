/// @description Fetch CSV from Google Sheet

// Giả lập tuần hiện tại nếu chưa được set ở nơi khác
if (!variable_global_exists("current_week")) {
    global.current_week = 1;
}

// Đặt trạng thái đang tải mỗi khi object này được sinh ra
global.current_theme_name = "Đang tải...";
global.current_theme_desc = "Đang lấy dữ liệu chủ đề mới nhất từ máy chủ...";

// Đường link Google Sheet (Nhớ thay bằng link thật của bạn)
// Đường link Google Sheet ĐÃ ĐƯỢC CẬP NHẬT
var url = "https://docs.google.com/spreadsheets/d/1ds-3WqUg3lcHnTeM7XNrDdTy5E8wQjoajuTqf-lOO1o/export?format=csv";

// Bắt đầu tải và lưu lại ID của Request để lắng nghe callback
request_id = http_get(url);

show_debug_message("Đang tải dữ liệu chủ đề tuần...");
