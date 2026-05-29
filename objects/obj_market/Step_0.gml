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
        if (menu_index < 0) menu_index = 6;
    }
    if (keyboard_check_pressed(vk_down)) {
        menu_index += 1;
        if (menu_index > 6) menu_index = 0;
    }

    // Chọn bằng Space hoặc Enter
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        switch (menu_index) {
            case 0:
                if (!global.unlocked_items.paper_grid) {
                    if (global.coins >= 30) { global.coins -= 30; global.unlocked_items.paper_grid = true; show_message("Đã mua Giấy Ô Vuông!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Giấy Ô Vuông rồi!");
                break;
            case 1:
                if (!global.unlocked_items.paper_vintage) {
                    if (global.coins >= 50) { global.coins -= 50; global.unlocked_items.paper_vintage = true; show_message("Đã mua Giấy Da Cổ!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Giấy Da Cổ rồi!");
                break;
            case 2:
                if (!global.unlocked_items.paper_rainbow) {
                    if (global.coins >= 80) { global.coins -= 80; global.unlocked_items.paper_rainbow = true; show_message("Đã mua Giấy Cầu Vồng!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Giấy Cầu Vồng rồi!");
                break;
            case 3:
                if (!global.unlocked_items.frame_daisy) {
                    if (global.coins >= 100) { global.coins -= 100; global.unlocked_items.frame_daisy = true; show_message("Đã mua Khung Hoa Cúc!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Khung Hoa Cúc rồi!");
                break;
            case 4:
                if (!global.unlocked_items.frame_superman) {
                    if (global.coins >= 150) { global.coins -= 150; global.unlocked_items.frame_superman = true; show_message("Đã mua Khung Siêu Nhân!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Khung Siêu Nhân rồi!");
                break;
            case 5:
                if (!global.unlocked_items.frame_sparkle) {
                    if (global.coins >= 200) { global.coins -= 200; global.unlocked_items.frame_sparkle = true; show_message("Đã mua Khung Lấp Lánh!"); }
                    else show_message("Bạn không đủ Xu!");
                } else show_message("Bạn đã sở hữu Khung Lấp Lánh rồi!");
                break;
            case 6:
                show_ui = false;
                break;
        }
    }

    // Nhấn Escape cũng đóng UI
    if (keyboard_check_pressed(vk_escape)) {
        show_ui = false;
    }
}
