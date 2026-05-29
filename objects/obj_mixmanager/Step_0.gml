/// @description Quản lý quá trình chuyển State và Pha màu

// 1. Chuyển State từ EXTRACT_COLOR sang MIXING_COLOR
if (global.phamau_state == PhaMauState.EXTRACT_COLOR) {
    if (array_length(global.tray_colors) == 3) {
        global.phamau_state = PhaMauState.MIXING_COLOR;
    }
}

// 2. Logic Trộn màu trong State MIXING_COLOR
if (global.phamau_state == PhaMauState.MIXING_COLOR) {
    if (array_length(global.mixing_queue) == 2) {
        var c1 = global.mixing_queue[0];
        var c2 = global.mixing_queue[1];
        var new_color = "";
        
        if ((c1 == "do" && c2 == "vang") || (c1 == "vang" && c2 == "do")) new_color = "cam";
        else if ((c1 == "vang" && c2 == "xanh") || (c1 == "xanh" && c2 == "vang")) new_color = "xanhla";
        else if ((c1 == "do" && c2 == "xanh") || (c1 == "xanh" && c2 == "do")) new_color = "tim";
        
        if (new_color != "") {
            var already_exists = false;
            for (var i = 0; i < array_length(global.tray_colors); i++) {
                if (global.tray_colors[i] == new_color) already_exists = true;
            }
            if (!already_exists) {
                array_push(global.tray_colors, new_color);
                
                // --- THÊM HIỆU ỨNG TẠI ĐÂY ---
                // Tạo hiệu ứng hạt lấp lánh (dùng hàm có sẵn của GameMaker)
                effect_create_above(ef_spark, mouse_x, mouse_y, 1, c_yellow);
                effect_create_above(ef_star, mouse_x, mouse_y + 10, 1, c_white);
                
                // Phát âm thanh "Ting!"
                // LƯU Ý: Bạn cần tạo một Sound tên là snd_ting trong thư mục Sounds trước khi bỏ comment dòng này nhé!
                audio_play_sound(snd_ting, 1, false);
            }
        }
        
        global.mixing_queue = [];
        
        if (array_length(global.tray_colors) == 6) {
            global.phamau_state = PhaMauState.CHOOSE_MODE;
        }
    }
}
