var gw = display_get_gui_width();
var gh = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1.0);

if (asset_get_index("Font1") != -1) {
    draw_set_font(Font1);
}
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed(gw/2, 60, "- PHÒNG CHUẨN BỊ -", 1.5, 1.5, 0);

draw_set_color(c_yellow);
draw_text_transformed(gw - 120, 60, "Xu: " + string(global.coins), 1.2, 1.2, 0);

// ===== KHU VỰC PREVIEW (Giữa) =====
var px = gw/2;
var py = gh/2;
var pw = 360;
var ph = 240;

if (variable_global_exists("draw_paper")) {
    global.draw_paper(px - pw/2, py - ph/2, pw, ph, temp_paper);
} else {
    draw_set_color(c_white); 
    draw_rectangle(px - pw/2, py - ph/2, px + pw/2, py + ph/2, false);
}

// Viền giả lập của giấy
draw_set_color(c_gray);
draw_rectangle(px - pw/2, py - ph/2, px + pw/2, py + ph/2, true);

// Vẽ Khung tranh
if (variable_global_exists("draw_frame")) {
    global.draw_frame(px - pw/2, py - ph/2, pw, ph, temp_frame, 20);
} else {
    draw_set_color(c_black);
    draw_rectangle(px - pw/2 - 20, py - ph/2 - 20, px + pw/2 + 20, py + ph/2 + 20, true);
}

// ===== MENU CHỌN =====
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var clicked = mouse_check_button_pressed(mb_left);

temp_paper = draw_list("- CHỌN GIẤY", papers, paper_names, temp_paper, gw/4, 200, mx, my, clicked, true);
temp_frame = draw_list("- CHỌN KHUNG", frames, frame_names, temp_frame, gw*3/4, 200, mx, my, clicked, false);

// ===== NÚT BẮT ĐẦU =====
var start_w = 220;
var start_h = 70;
var start_x = gw/2 - start_w/2;
var start_y = gh - 120;

var hover_start = (mx >= start_x && mx <= start_x + start_w && my >= start_y && my <= start_y + start_h);
if (hover_start) global.hover_active = true;

draw_set_color(hover_start ? make_color_rgb(255, 120, 120) : make_color_rgb(220, 60, 60));
draw_roundrect_ext(start_x, start_y, start_x + start_w, start_y + start_h, 20, 20, false);
draw_set_color(c_black);
draw_roundrect_ext(start_x, start_y, start_x + start_w, start_y + start_h, 20, 20, true);

draw_set_color(c_white);
draw_text_transformed(gw/2, start_y + start_h/2, "BẮT ĐẦU VẼ!", 1.2, 1.2, 0);

if (hover_start && clicked) {
    global.selected_paper = temp_paper;
    global.selected_frame = temp_frame;
    room_goto(room_tomau);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
