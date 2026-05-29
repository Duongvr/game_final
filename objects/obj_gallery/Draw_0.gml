// Draw Event for obj_gallery
draw_self();

if (show_prompt) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    // Viền đen cho chữ dễ đọc
    draw_set_color(c_black);
    draw_text(x - 1, bbox_top - 10, "Nhấn E để vào phòng trưng bày");
    draw_text(x + 1, bbox_top - 10, "Nhấn E để vào phòng trưng bày");
    draw_text(x, bbox_top - 11, "Nhấn E để vào phòng trưng bày");
    draw_text(x, bbox_top - 9, "Nhấn E để vào phòng trưng bày");
    
    // Chữ trắng
    draw_set_color(c_white);
    draw_text(x, bbox_top - 10, "Nhấn E để vào phòng trưng bày");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
