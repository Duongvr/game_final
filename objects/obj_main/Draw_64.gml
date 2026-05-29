// Draw GUI Event - Nhắc nhở khi đứng gần phòng tranh
if (near_gallery) {
    var gw = display_get_gui_width();
    var txt = "Nhấn E để vào Phòng Tranh";
    var tx = gw / 2;
    var ty = display_get_gui_height() - 60;

    draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Viền đen (outline 4 hướng)
    draw_set_color(c_black);
    draw_text(tx - 1, ty,     txt);
    draw_text(tx + 1, ty,     txt);
    draw_text(tx,     ty - 1, txt);
    draw_text(tx,     ty + 1, txt);

    // Chữ trắng nổi bật
    draw_set_color(c_white);
    draw_text(tx, ty, txt);

    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
