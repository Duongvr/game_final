// Step Event cho obj_painting_frame
var in_range = false;

// Kiem tra khoang cach toi obj_main
if (instance_exists(obj_main)) {
    if (distance_to_object(obj_main) < 150) {
        in_range = true;
    }
}

is_hovered = in_range;

if (is_hovered) {
    if (keyboard_check_pressed(ord("E"))) {
        show_message_async("Tên tranh: " + p_name + "\nĐộ hoàn thiện: " + string(floor(p_progress * 100)) + "%\nGiá trị: " + string(p_value) + " xu");
    }
    
    if (keyboard_check_pressed(ord("B"))) {
        if (!variable_global_exists("money")) global.money = 0;
        
        global.money += p_value;
        show_message_async("Đã bán tranh! Bạn nhận được " + string(p_value) + " xu.");
        
        // Xoa khoi mang global
        if (array_index < array_length(global.saved_paintings)) {
            array_delete(global.saved_paintings, array_index, 1);
        }
        
        // Giảm số lượng tranh đang treo
        if (variable_global_exists("paintings_hung") && global.paintings_hung > 0) {
            global.paintings_hung -= 1;
        }
        
        // Refresh lai phong trung bay
        room_restart();
    }
}
