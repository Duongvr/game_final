// Step Event cho obj_painting_frame
var in_range = false;

// Kiem tra khoang cach ngang toi obj_main
if (instance_exists(obj_main)) {
    if (abs(x - obj_main.x) < 150) {
        in_range = true;
    }
}

is_hovered = in_range;

if (is_hovered) {
    // Mở popup
    if (variable_instance_exists(id, "show_detail") && show_detail) {
        if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"))) {
            show_detail = false;
        }
    } else {
        if (keyboard_check_pressed(ord("E"))) {
            show_detail = true;
        }
    }
    
    // Bán tranh
    if (keyboard_check_pressed(ord("B"))) {
        if (!variable_global_exists("coins")) global.coins = 0;
        
        global.coins += p_value;
        if (asset_get_index("snd_ting") != -1) {
            audio_play_sound(snd_ting, 1, false);
        }
        
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
} else {
    // Nếu đi xa khỏi tranh thì đóng popup
    show_detail = false;
}
