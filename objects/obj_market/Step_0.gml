// Step Event for obj_market
if (instance_exists(obj_main)) {
    if (distance_to_object(obj_main) < 80) {
        // Nhấn E để bật/tắt UI chợ
        if (keyboard_check_pressed(ord("E"))) {
            show_ui = !show_ui;
            menu_index = 0;
            
            // Khởi tạo biến quản lý khung và nền nếu chưa có
            if (!variable_global_exists("unlocked_frames")) global.unlocked_frames = [true, false, false];
            if (!variable_global_exists("unlocked_bgs")) global.unlocked_bgs = [true, false];
        }
    } else {
        // Tự đóng UI khi đi xa
        show_ui = false;
    }
}

if (show_ui) {
    // Điều hướng menu bằng phím mũi tên
    if (keyboard_check_pressed(vk_up)) {
        menu_index -= 1;
        if (menu_index < 0) menu_index = 3;
    }
    if (keyboard_check_pressed(vk_down)) {
        menu_index += 1;
        if (menu_index > 3) menu_index = 0;
    }

    // Chọn bằng Space hoặc Enter
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        switch (menu_index) {
            case 0: // Mua Khung Gỗ
                if (array_length(global.unlocked_frames) > 1 && !global.unlocked_frames[1]) {
                    if (global.money >= 50) {
                        global.money -= 50;
                        global.unlocked_frames[1] = true;
                        show_message("Đã mua Khung Gỗ thành công!");
                    } else {
                        show_message("Bạn không đủ tiền!");
                    }
                } else {
                    show_message("Bạn đã sở hữu Khung Gỗ rồi!");
                }
                break;
            case 1: // Mua Khung Vàng
                if (array_length(global.unlocked_frames) > 2 && !global.unlocked_frames[2]) {
                    if (global.money >= 150) {
                        global.money -= 150;
                        global.unlocked_frames[2] = true;
                        show_message("Đã mua Khung Vàng thành công!");
                    } else {
                        show_message("Bạn không đủ tiền!");
                    }
                } else {
                    show_message("Bạn đã sở hữu Khung Vàng rồi!");
                }
                break;
            case 2: // Mua Giấy Vẽ Nhám (Background)
                if (array_length(global.unlocked_bgs) > 1 && !global.unlocked_bgs[1]) {
                    if (global.money >= 100) {
                        global.money -= 100;
                        global.unlocked_bgs[1] = true;
                        show_message("Đã mua Giấy Vẽ Nhám thành công!");
                    } else {
                        show_message("Bạn không đủ tiền!");
                    }
                } else {
                    show_message("Bạn đã sở hữu Giấy Vẽ Nhám rồi!");
                }
                break;
            case 3: // Đóng
                show_ui = false;
                break;
        }
    }

    // Nhấn Escape cũng đóng UI
    if (keyboard_check_pressed(vk_escape)) {
        show_ui = false;
    }
}
