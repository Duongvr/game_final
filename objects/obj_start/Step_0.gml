// Step Event
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

is_hover = point_in_rectangle(mx, my,
    btn_x - btn_w/2, btn_y - btn_h/2,
    btn_x + btn_w/2, btn_y + btn_h/2);

// Glow pulse khi hover
if (is_hover) {
    alpha_glow = lerp(alpha_glow, 1, 0.12);
    if (mouse_check_button_pressed(mb_left)) {
        is_pressed = true;
    }
    if (mouse_check_button_released(mb_left) && is_pressed) {
        is_pressed = false;
        // Chuyển sang room game chính
        room_goto(room_game);
    }
} else {
    alpha_glow = lerp(alpha_glow, 0, 0.10);
    is_pressed = false;
}
