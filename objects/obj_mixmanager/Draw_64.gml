/// @description Vẽ UI Chọn Chế độ và Hiển thị màu

draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// =================================================
// TEXT HƯỚNG DẪN THEO STATE
// =================================================
var txt = "";
if (global.phamau_state == PhaMauState.EXTRACT_COLOR) {
    txt = "Hãy bấm vào 3 lọ màu trên bàn để lấy màu!";
} else if (global.phamau_state == PhaMauState.MIXING_COLOR) {
    txt = "Bấm 2 màu bất kỳ trên KHAY MÀU để trộn!";
} else if (global.phamau_state == PhaMauState.CHOOSE_MODE) {
    txt = "Đã pha xong 6 màu! Hãy chọn chế độ chơi.";
}

var tx = display_get_gui_width() / 2;
var ty = 50;

draw_set_color(c_black);
draw_text(tx - 1, ty, txt);
draw_text(tx + 1, ty, txt);
draw_text(tx, ty - 1, txt);
draw_text(tx, ty + 1, txt);
draw_set_color(c_white);
draw_text(tx, ty, txt);

// =================================================
// VẼ GIAO DIỆN CHỌN CHẾ ĐỘ
// =================================================
if (global.phamau_state == PhaMauState.CHOOSE_MODE) {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var cx = gw / 2;
    var cy = gh / 2;
    
    // Nền tối mờ
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, gw, gh, false);
    
    // Khung popup
    draw_set_alpha(1.0);
    var popup_w = 460;
    var popup_h = 280;
    var px1 = cx - popup_w/2;
    var py1 = cy - popup_h/2;
    var px2 = cx + popup_w/2;
    var py2 = cy + popup_h/2;
    
    // Đổ bóng khung
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_roundrect_ext(px1 + 8, py1 + 8, px2 + 8, py2 + 8, 20, 20, false);
    
    // Nền khung
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 248, 230)); // Màu be sáng
    draw_roundrect_ext(px1, py1, px2, py2, 20, 20, false);
    
    // Viền khung
    draw_set_color(make_color_rgb(200, 150, 100)); // Màu nâu nhạt
    draw_roundrect_ext(px1, py1, px2, py2, 20, 20, true);
    draw_roundrect_ext(px1+1, py1+1, px2-1, py2-1, 20, 20, true);
    
    // Tiêu đề
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(220, 60, 60)); // Màu đỏ
    draw_text_transformed(cx, py1 + 60, "PHA MÀU THÀNH CÔNG!", 1.4, 1.4, 0);
    
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_text_transformed(cx, py1 + 110, "Hãy chọn chế độ bạn muốn chơi", 1.1, 1.1, 0);
    
    // Tọa độ chuột
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    // Cài đặt nút chung
    var btn_w = 160;
    var btn_h = 70;
    
    // === NÚT VẼ TỰ DO ===
    var free_x1 = cx - btn_w - 20;
    var free_y1 = cy + 30;
    var free_x2 = free_x1 + btn_w;
    var free_y2 = free_y1 + btn_h;
    
    var hover_free = (mx >= free_x1 && mx <= free_x2 && my >= free_y1 && my <= free_y2);
    var scale_f = hover_free ? 1.05 : 1.0;
    
    // Vẽ nút (tính toán lại tọa độ để scale từ tâm)
    var f_cx = (free_x1 + free_x2) / 2;
    var f_cy = (free_y1 + free_y2) / 2;
    var f_w2 = (btn_w / 2) * scale_f;
    var f_h2 = (btn_h / 2) * scale_f;
    
    // Đổ bóng nút
    draw_set_color(c_black);
    draw_set_alpha(0.2);
    draw_roundrect_ext(f_cx - f_w2 + 4, f_cy - f_h2 + 4, f_cx + f_w2 + 4, f_cy + f_h2 + 4, 15, 15, false);
    
    draw_set_alpha(1.0);
    draw_set_color(hover_free ? make_color_rgb(100, 220, 100) : make_color_rgb(70, 180, 70));
    draw_roundrect_ext(f_cx - f_w2, f_cy - f_h2, f_cx + f_w2, f_cy + f_h2, 15, 15, false);
    
    draw_set_color(c_white);
    draw_text_transformed(f_cx, f_cy, "VẼ TỰ DO", scale_f, scale_f, 0);
    
    // === NÚT TÔ MÀU ===
    var color_x1 = cx + 20;
    var color_y1 = cy + 30;
    var color_x2 = color_x1 + btn_w;
    var color_y2 = color_y1 + btn_h;
    
    var hover_color = (mx >= color_x1 && mx <= color_x2 && my >= color_y1 && my <= color_y2);
    var scale_c = hover_color ? 1.05 : 1.0;
    
    var c_cx = (color_x1 + color_x2) / 2;
    var c_cy = (color_y1 + color_y2) / 2;
    var c_w2 = (btn_w / 2) * scale_c;
    var c_h2 = (btn_h / 2) * scale_c;
    
    draw_set_color(c_black);
    draw_set_alpha(0.2);
    draw_roundrect_ext(c_cx - c_w2 + 4, c_cy - c_h2 + 4, c_cx + c_w2 + 4, c_cy + c_h2 + 4, 15, 15, false);
    
    draw_set_alpha(1.0);
    draw_set_color(hover_color ? make_color_rgb(100, 180, 255) : make_color_rgb(60, 130, 220));
    draw_roundrect_ext(c_cx - c_w2, c_cy - c_h2, c_cx + c_w2, c_cy + c_h2, 15, 15, false);
    
    draw_set_color(c_white);
    draw_text_transformed(c_cx, c_cy, "TÔ MÀU", scale_c, scale_c, 0);
    
    // Reset align
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // === XỬ LÝ CLICK ===
    if (mouse_check_button_pressed(mb_left)) {
        if (hover_free) {
            global.draw_mode = "free";
            room_goto(rm_prepare_canvas); 
        }
        else if (hover_color) {
            global.draw_mode = "coloring";
            room_goto(rm_prepare_canvas); 
        }
    }
}