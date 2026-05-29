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
        if (menu_index < 0) menu_index = 4;
    }
    if (keyboard_check_pressed(vk_down)) {
        menu_index += 1;
        if (menu_index > 4) menu_index = 0;
    }

    // Chọn bằng Space hoặc Enter
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        switch (menu_index) {
            case 0: // Mua Giay O Vuong
                if (!global.unlocked_items.paper_grid) {
                    if (global.coins >= 50) {
                        global.coins -= 50;
                        global.unlocked_items.paper_grid = true;
                        show_message("Đã mua Giấy Ô Vuông thành công!");
                    } else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Giấy Ô Vuông rồi!");
                break;
            case 1: // Mua Giay Cau Vong
                if (!global.unlocked_items.paper_rainbow) {
                    if (global.coins >= 100) {
                        global.coins -= 100;
                        global.unlocked_items.paper_rainbow = true;
                        show_message("Đã mua Giấy Cầu Vồng thành công!");
                    } else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Giấy Cầu Vồng rồi!");
                break;
            case 2: // Mua Khung Hoa Cuc
                if (!global.unlocked_items.frame_daisy) {
                    if (global.coins >= 120) {
                        global.coins -= 120;
                        global.unlocked_items.frame_daisy = true;
                        show_message("Đã mua Khung Hoa Cúc thành công!");
                    } else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Khung Hoa Cúc rồi!");
                break;
            case 3: // Mua Khung Sieu Nhan
                if (!global.unlocked_items.frame_superman) {
                    if (global.coins >= 200) {
                        global.coins -= 200;
                        global.unlocked_items.frame_superman = true;
                        show_message("Đã mua Khung Siêu Nhân thành công!");
                    } else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Khung Siêu Nhân rồi!");
                break;
            case 4: // Đóng
                show_ui = false;
                break;
        }
    }

    // Nhấn Escape cũng đóng UI
    if (keyboard_check_pressed(vk_escape)) {
        show_ui = false;
    }
}
