// Draw Event - obj_tranh_tu_do
var canvas_x1 = x;
var canvas_y1 = y;

if (!surface_exists(surf)) {
    surf = surface_create(canvas_w, canvas_h);
    surface_set_target(surf);
    draw_clear_alpha(c_white, 0); 
    surface_reset_target();
}

// 1) Vẽ nền giấy
if (variable_global_exists("draw_paper") && variable_global_exists("selected_paper")) {
    global.draw_paper(canvas_x1, canvas_y1, canvas_w, canvas_h, global.selected_paper);
} else {
    draw_self();
}

draw_surface(surf, canvas_x1, canvas_y1);

// Vẽ KHUNG TRANH ĐÈ LÊN TRÊN
if (variable_global_exists("draw_frame") && variable_global_exists("selected_frame")) {
    global.draw_frame(canvas_x1, canvas_y1, canvas_w, canvas_h, global.selected_frame, 20);
}

var mx = mouse_x;
var my = mouse_y;
var in_canvas = (mx >= canvas_x1 && mx < canvas_x1 + canvas_w
              && my >= canvas_y1 && my < canvas_y1 + canvas_h);

if (global.selected_color != c_white && in_canvas) {
    draw_set_alpha(0.85);
    draw_set_color(global.selected_color);
    draw_circle(mx, my, brush_size, false);
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_circle(mx, my, brush_size, true);
    draw_line(mx - 3, my, mx + 3, my);
    draw_line(mx, my - 3, mx, my + 3);
}

// 5) Hướng dẫn hoàn thành
var hint_txt = "Nhấn phím SPACE/ENTER hoặc nút XONG để nộp tranh | Lăn chuột để đổi nét cọ to nhỏ nhé!";
var hy = canvas_y1 + canvas_h + 65;
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text(canvas_x1 + canvas_w/2 - 1, hy, hint_txt);
draw_text(canvas_x1 + canvas_w/2 + 1, hy, hint_txt);
draw_set_color(c_ltgray);
draw_text(canvas_x1 + canvas_w/2, hy, hint_txt);
draw_set_halign(fa_left);

// 7) Hiển thị tên màu đang chọn ở góc dưới trái
if (global.selected_color != c_white) {
    var color_name = "";
    if (global.selected_color == c_red) color_name = "Màu đỏ";
    else if (global.selected_color == c_yellow) color_name = "Màu vàng";
    else if (global.selected_color == c_blue) color_name = "Màu xanh dương";
    else if (global.selected_color == c_orange) color_name = "Màu cam";
    else if (global.selected_color == c_lime) color_name = "Màu xanh lá";
    else if (global.selected_color == c_purple) color_name = "Màu tím";
    
    if (color_name != "") {
        draw_set_alpha(1);
        draw_set_color(global.selected_color);
        draw_text(10, display_get_gui_height() - 30, "Đang chọn: " + color_name);
    }
}

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- VẼ NÚT "XONG" ---
if (!is_finished) {
    var btn_done_w = 120;
    var btn_done_h = 40;
    var btn_done_x = canvas_x1 + canvas_w - btn_done_w;
    var btn_done_y = canvas_y1 + canvas_h + 10;
    
    // Nếu chưa vẽ đủ thì làm mờ nút đi một chút
    var can_finish = (variable_instance_exists(id, "pixels_painted") && pixels_painted > 500);
    
    var hover_done = (mx >= btn_done_x && mx <= btn_done_x + btn_done_w && my >= btn_done_y && my <= btn_done_y + btn_done_h);
    
    if (can_finish) {
        draw_set_color(hover_done ? c_lime : c_green);
    } else {
        draw_set_color(hover_done ? make_color_rgb(150, 150, 150) : c_gray);
    }
    
    draw_roundrect(btn_done_x, btn_done_y, btn_done_x + btn_done_w, btn_done_y + btn_done_h, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_text(btn_done_x + btn_done_w/2, btn_done_y + btn_done_h/2 + 3, "XONG");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// 8) ANIMATION HOÀN THÀNH TRANH
if (variable_instance_exists(id, "is_finished") && is_finished) {
    finish_alpha = min(finish_alpha + 0.02, 1); 
    
    draw_set_color(c_black);
    draw_set_alpha(finish_alpha * 0.85);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    draw_set_alpha(finish_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (asset_get_index("Font1") != -1) {
        draw_set_font(Font1);
    }
    
    var text_x = room_width / 2;
    var text_y = room_height / 2 - 30;
    
    // --- VẼ CÁC TRẠNG THÁI LỰA CHỌN ---
    if (finish_alpha >= 0.9) {
        if (show_receipt) {
            var rx = room_width / 2;
            var ry = room_height / 2 - 80;
            draw_set_color(c_white);
            draw_text_transformed(rx, ry, "--- TỔNG KẾT BÁN TRANH ---", 1.2, 1.2, 0);
            draw_text(rx, ry + 40, "Tiền công cơ bản: " + string(receipt_data.g_cb) + " Xu");
            draw_text(rx, ry + 70, "Thưởng màu sắc (" + string(receipt_data.s_m / 10) + " màu): " + string(receipt_data.s_m) + " Xu");
            draw_text(rx, ry + 100, "Thưởng đúng chủ đề: " + string(receipt_data.t_cd) + " Xu");
            draw_set_color(c_yellow);
            draw_text_transformed(rx, ry + 140, "TỔNG NHẬN: " + string(receipt_data.total) + " Xu", 1.5, 1.5, 0);
            
            var btn_w = 120;
            var btn_h = 40;
            var btn_x = rx - btn_w / 2;
            var btn_y = ry + 180;
            var hover_done2 = (mx >= btn_x && mx <= btn_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
            draw_set_color(hover_done2 ? c_lime : c_green);
            draw_roundrect(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
            draw_set_color(c_white);
            draw_text(rx, btn_y + btn_h/2, "NHẬN TIỀN");
        } else if (asking_theme) {
            var cx = room_width / 2;
            var cy = room_height / 2 - 50;
            draw_set_color(c_white);
            draw_text_transformed(cx, cy, "Bé có vẽ đúng chủ đề không?", 1.2, 1.2, 0);
            draw_set_color(c_yellow);
            if (variable_global_exists("current_theme_name")) {
                draw_text(cx, cy + 30, "[" + global.current_theme_name + "]");
            }
            
            var btn_w = 150;
            var btn_h = 50;
            var btn1_x = cx - 170;
            var btn2_x = cx + 20;
            var btn_y = cy + 100;
            
            var hover1 = (mx >= btn1_x && mx <= btn1_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
            var hover2 = (mx >= btn2_x && mx <= btn2_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
            
            draw_set_color(hover1 ? c_lime : c_green);
            draw_roundrect(btn1_x, btn_y, btn1_x + btn_w, btn_y + btn_h, false);
            draw_set_color(c_white);
            draw_text(btn1_x + btn_w/2, btn_y + btn_h/2, "CÓ");
            
            draw_set_color(hover2 ? make_color_rgb(255, 100, 100) : c_red);
            draw_roundrect(btn2_x, btn_y, btn2_x + btn_w, btn_y + btn_h, false);
            draw_set_color(c_white);
            draw_text(btn2_x + btn_w/2, btn_y + btn_h/2, "KHÔNG");
        } else {
            draw_set_color(c_white);
            draw_text_transformed(text_x, text_y - 20, "Tranh đã vẽ xong!", 1.5, 1.5, 0);
            draw_set_color(c_yellow);
            draw_text(text_x, text_y + 20, "Bạn muốn Trưng bày hay Bán lấy xu?");
            
            var btn_w = 150;
            var btn_h = 50;
            var btn1_x = text_x - 170;
            var btn2_x = text_x + 20;
            var btn_y = text_y + 80;
            
            var hover1 = (mx >= btn1_x && mx <= btn1_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
            var hover2 = (mx >= btn2_x && mx <= btn2_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
            
            draw_set_color(hover1 ? c_aqua : c_blue);
            draw_roundrect(btn1_x, btn_y, btn1_x + btn_w, btn_y + btn_h, false);
            draw_set_color(c_white);
            draw_text(btn1_x + btn_w/2, btn_y + btn_h/2, "TRƯNG BÀY");
            
            draw_set_color(hover2 ? c_lime : c_green);
            draw_roundrect(btn2_x, btn_y, btn2_x + btn_w, btn_y + btn_h, false);
            draw_set_color(c_white);
            draw_text(btn2_x + btn_w/2, btn_y + btn_h/2, "BÁN LẤY XU");
        }
    }
    
    draw_set_alpha(1);
}

// ========================================
// VẼ THÔNG BÁO LỖI CHƯA VẼ
// ========================================
if (variable_instance_exists(id, "msg_timer") && msg_timer > 0 && msg_text != "") {
    var notif_alpha = min(1, msg_timer / 20);
    draw_set_alpha(notif_alpha);
    
    draw_set_color(c_black);
    draw_roundrect(room_width/2 - string_width(msg_text)/2 - 20, room_height - 90, room_width/2 + string_width(msg_text)/2 + 20, room_height - 40, false);
    
    draw_set_color(c_yellow);
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text(room_width/2, room_height - 65, msg_text);
    
    draw_set_alpha(1);
    draw_set_halign(fa_left); draw_set_valign(fa_top);
}
