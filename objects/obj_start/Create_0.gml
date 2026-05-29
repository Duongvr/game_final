// Create Event
btn_x = display_get_gui_width() / 2;
btn_y = display_get_gui_height() * 0.62;
btn_w = 390;
btn_h = 80;
is_hover = false;
is_pressed = false;
alpha_glow = 0;

// Khởi tạo biến toàn cục (Global Variables)
global.selected_color = c_white;
global.money = 0;
global.paintings_owned = 0;
global.paintings_hung = 0;
global.frames = 0;

if (!instance_exists(obj_GameManager)) {
    instance_create_layer(0, 0, layer, obj_GameManager);
}
