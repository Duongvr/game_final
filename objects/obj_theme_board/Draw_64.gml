var gw = display_get_gui_width();
var gh = display_get_gui_height();

var bx = gw / 2;
var by = 40;
var bw = 650; // Mở rộng chiều ngang bảng gỗ
var bh = 110; // Mở rộng chiều dọc bảng gỗ

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var clicked = mouse_check_button_pressed(mb_left);

if (is_visible) {
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(139, 69, 19)); 
    draw_roundrect(bx - bw/2, by, bx + bw/2, by + bh, false);
    draw_set_color(make_color_rgb(222, 184, 135)); 
    draw_roundrect(bx - bw/2 + 5, by + 5, bx + bw/2 - 5, by + bh - 5, false);
    
    draw_set_color(c_dkgray);
    draw_circle(bx - bw/2 + 15, by + 15, 5, false);
    draw_circle(bx + bw/2 - 15, by + 15, 5, false);
    draw_circle(bx - bw/2 + 15, by + bh - 15, 5, false);
    draw_circle(bx + bw/2 - 15, by + bh - 15, 5, false);

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    
    var theme_name = variable_global_exists("current_theme_name") ? global.current_theme_name : "Chủ đề tự do";
    var theme_desc = variable_global_exists("current_theme_desc") ? global.current_theme_desc : "Thỏa sức sáng tạo!";
    
    draw_text_transformed(bx, by + 15, "- Chủ đề tuần này: " + string(theme_name) + " -", 1.2, 1.2, 0);
    
    draw_set_color(make_color_rgb(60, 60, 60));
    // Dùng draw_text_ext để tự động ngắt dòng nếu văn bản dài quá chiều rộng của bảng (bw - 30)
    draw_text_ext(bx, by + 50, string(theme_desc), 25, bw - 30);
    
    var mas_x = bx - bw/2 - 30;
    var mas_y = by + bh/2;
    var hover_mascot = point_distance(mx, my, mas_x, mas_y) < 35;
    
    draw_set_color(c_yellow);
    draw_circle(mas_x, mas_y, 35, false);
    draw_set_color(c_black);
    draw_circle(mas_x, mas_y, 35, true);
    draw_circle(mas_x - 12, mas_y - 10, 4, false); 
    draw_circle(mas_x + 12, mas_y - 10, 4, false); 
    draw_line_width(mas_x - 15, mas_y + 12, mas_x + 15, mas_y + 12, 3); 
    
    if (hover_mascot && clicked) {
        // Tương tác (có thể play sound)
        if (asset_get_index("snd_ting") != -1) {
            audio_play_sound(snd_ting, 1, false);
        }
    }
    
    var x_bx = bx + bw/2 - 25;
    var x_by = by + 25;
    var hover_x = (mx > x_bx - 15 && mx < x_bx + 15 && my > x_by - 15 && my < x_by + 15);
    
    draw_set_color(hover_x ? c_red : make_color_rgb(200, 50, 50));
    draw_circle(x_bx, x_by, 16, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x_bx, x_by, "X");
    
    if (hover_x && clicked) {
        is_visible = false;
    }

} else {
    var show_x = gw/2;
    var show_y = 30;
    var hover_show = (mx > show_x - 70 && mx < show_x + 70 && my > show_y - 25 && my < show_y + 25);
    
    draw_set_color(hover_show ? make_color_rgb(100, 180, 255) : make_color_rgb(50, 150, 200));
    draw_roundrect(show_x - 70, show_y - 25, show_x + 70, show_y + 25, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(show_x, show_y, "Hiển thị Chủ Đề");
    
    if (hover_show && clicked) {
        is_visible = true;
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
