// Draw Event for obj_gallery_controller
if (variable_instance_exists(id, "near_door") && near_door) {
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    // Viền chữ
    draw_set_color(c_black);
    draw_text(door_x - 1, door_y - 20, "Nhấn E để thoát khỏi phòng trưng bày");
    draw_text(door_x + 1, door_y - 20, "Nhấn E để thoát khỏi phòng trưng bày");
    draw_text(door_x, door_y - 21, "Nhấn E để thoát khỏi phòng trưng bày");
    draw_text(door_x, door_y - 19, "Nhấn E để thoát khỏi phòng trưng bày");
    
    // Chữ chính
    draw_set_color(c_white);
    draw_text(door_x, door_y - 20, "Nhấn E để thoát khỏi phòng trưng bày");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
