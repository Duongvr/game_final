// Draw GUI Event for obj_gallery_controller
if (asset_get_index("Font1") != -1) {
    draw_set_font(Font1);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text(11, 11, "Nhấn ESC để quay lại");
draw_set_color(c_white);
draw_text(10, 10, "Nhấn ESC để quay lại");
