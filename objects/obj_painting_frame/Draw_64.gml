// Draw GUI Event for obj_painting_frame

if (variable_instance_exists(id, "show_detail") && show_detail) {
    // Kích thước màn hình
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    
    // Nền đen mờ
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    
    // Panel chính
    var panel_w = 800;
    var panel_h = 600;
    var px = (gw - panel_w) / 2;
    var py = (gh - panel_h) / 2;
    
    // Vẽ viền và nền panel
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_roundrect(px, py, px + panel_w, py + panel_h, false);
    draw_set_color(c_yellow);
    draw_roundrect(px - 2, py - 2, px + panel_w + 2, py + panel_h + 2, true);
    
    // Vẽ tranh to ở giữa panel
    if (sprite_exists(spr_painting)) {
        var sw = sprite_get_width(spr_painting);
        var sh = sprite_get_height(spr_painting);
        
        var max_w = 700;
        var max_h = 400;
        var scale = min(max_w / sw, max_h / sh);
        
        var draw_w = sw * scale;
        var draw_h = sh * scale;
        
        // Vẽ viền cho tranh
        draw_set_color(c_white);
        var img_x = gw / 2;
        var img_y = py + 50 + draw_h / 2;
        
        draw_rectangle(img_x - draw_w/2 - 5, img_y - draw_h/2 - 5, img_x + draw_w/2 + 5, img_y + draw_h/2 + 5, false);
        draw_sprite_ext(spr_painting, 0, img_x - draw_w/2, img_y - draw_h/2, scale, scale, 0, c_white, 1);
    }
    
    // Text chi tiết
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_y = py + panel_h - 100;
    draw_set_color(c_yellow);
    draw_text_transformed(gw / 2, text_y, p_name, 1.2, 1.2, 0);
    
    draw_set_color(c_white);
    draw_text(gw / 2, text_y + 35, "Độ hoàn thiện: " + string(floor(p_progress * 100)) + "%   |   Định giá: " + string(p_value) + " Xu");
    
    draw_set_color(c_lime);
    draw_text(gw / 2, text_y + 65, "Nhấn [B] để Bán tranh");
    
    draw_set_color(c_gray);
    draw_text(gw / 2, text_y + 95, "Nhấn [E] hoặc [ESC] để đóng");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
