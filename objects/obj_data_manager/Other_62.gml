/// @description Parse CSV Data

// Kiểm tra đúng request ID của object này
if (async_load[? "id"] == request_id) {
    
    // Status == 0 nghĩa là HTTP Request thành công
    if (async_load[? "status"] == 0) {
        var result_str = async_load[? "result"];
        
        // --- BỘ PHÂN TÍCH CSV (CSV PARSER) BẰNG GML THUẦN ---
        var _len = string_length(result_str);
        var _in_quotes = false;
        var _current_val = "";
        var _cols = [];
        var _lines = [];
        
        // Quét từng ký tự để phân tách Cột và Dòng (Hỗ trợ dấu phẩy trong ngoặc kép)
        for (var i = 1; i <= _len; i++) {
            var _char = string_char_at(result_str, i);
            
            if (_char == "\"") {
                _in_quotes = !_in_quotes; // Đảo trạng thái ngoặc kép
            } 
            else if (_char == "," && !_in_quotes) {
                // Hết một cột
                array_push(_cols, string_trim(_current_val));
                _current_val = "";
            } 
            else if ((_char == "\n" || _char == "\r") && !_in_quotes) {
                // Hết một dòng
                // Xử lý \r\n đi liền nhau của Windows
                if (_char == "\r" && i < _len && string_char_at(result_str, i + 1) == "\n") {
                    continue; // Bỏ qua \r, để nhường \n chốt dòng
                }
                
                array_push(_cols, string_trim(_current_val));
                array_push(_lines, _cols);
                
                // Reset mảng cột cho dòng mới
                _cols = [];
                _current_val = "";
            } 
            else {
                // Cộng dồn ký tự vào dữ liệu ô hiện tại
                _current_val += _char;
            }
        }
        
        // Chốt dữ liệu của dòng cuối cùng (nếu file không kết thúc bằng dấu xuống dòng)
        if (_current_val != "" || array_length(_cols) > 0) {
            array_push(_cols, string_trim(_current_val));
            array_push(_lines, _cols);
        }
        
        // --- TÌM KIẾM THEO ID TUẦN ---
        var _found = false;
        var _target_week = string(global.current_week); // Ép kiểu string để so sánh an toàn
        
        // Bắt đầu từ index 1 để bỏ qua dòng 0 (dòng Tiêu đề cột của Google Sheet)
        for (var r = 1; r < array_length(_lines); r++) {
            var _row = _lines[r];
            
            // Cấu trúc dòng chuẩn phải có đủ 3 cột: ID, Name, Desc
            if (array_length(_row) >= 3) {
                var _week_id = _row[0];
                
                if (_week_id == _target_week) {
                    global.current_theme_name = _row[1];
                    global.current_theme_desc = _row[2];
                    _found = true;
                    
                    show_debug_message("==== CẬP NHẬT CHỦ ĐỀ THÀNH CÔNG ====");
                    show_debug_message("Tuần: " + _week_id);
                    show_debug_message("Tên: " + global.current_theme_name);
                    show_debug_message("Mô tả: " + global.current_theme_desc);
                    break;
                }
            }
        }
        
        if (!_found) {
            show_debug_message("CẢNH BÁO: Không tìm thấy dữ liệu cho Tuần " + _target_week);
        }
        
    } else {
        show_debug_message("LỖI HTTP: Không thể tải CSV. Mã lỗi: " + string(async_load[? "status"]));
    }
}
