// Draw Event - obj_tranh
// Origin spr_tranh = (0,0) => vẽ sprite từ (x, y)
var canvas_x1 = x;
var canvas_y1 = y;
var canvas_w   = 700;
var canvas_h   = 382;

// Tạo surface nếu chưa có
if (!surface_exists(surf)) {
    surf = surface_create(canvas_w, canvas_h);
    surface_set_target(surf);
    draw_clear_alpha(c_white, 0); // Nền trong suốt
    surface_reset_target();
}

// 1) Vẽ nền giấy
if (variable_global_exists("draw_paper") && variable_global_exists("selected_paper")) {
    global.draw_paper(canvas_x1, canvas_y1, canvas_w, canvas_h, global.selected_paper);
} else {
    draw_self();
}

// 2) Vẽ nội dung đã tô lên trên (căn chính xác góc trên trái)
draw_surface(surf, canvas_x1, canvas_y1);

// 2.5) Vẽ KHUNG TRANH ĐÈ LÊN TRÊN
if (variable_global_exists("draw_frame") && variable_global_exists("selected_frame")) {
    global.draw_frame(canvas_x1, canvas_y1, canvas_w, canvas_h, global.selected_frame, 20);
}

// [NEW] Vẽ nét tranh lên trên cùng để hiện nét vẽ khi tô
if (instance_exists(obj_net_tranh)) {
    var inst = instance_find(obj_net_tranh, 0);
    draw_sprite_ext(inst.sprite_index, inst.image_index, inst.x, inst.y, inst.image_xscale, inst.image_yscale, inst.image_angle, inst.image_blend, inst.image_alpha);
}

// 3) Con trỏ chuột tùy chỉnh - chỉ hiện trong canvas
var mx = mouse_x;
var my = mouse_y;
var in_canvas = (mx >= canvas_x1 && mx < canvas_x1 + canvas_w
              && my >= canvas_y1 && my < canvas_y1 + canvas_h);

if (global.selected_color != c_white && in_canvas) {
    // Vòng tròn với màu đang chọn + viền đen
    draw_set_alpha(0.85);
    draw_set_color(global.selected_color);
    draw_circle(mx, my, brush_size, false);
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_circle(mx, my, brush_size, true);
    // Dấu thập nhỏ ở tâm bút
    draw_line(mx - 3, my, mx + 3, my);
    draw_line(mx, my - 3, mx, my + 3);
}

// 4) Thanh tiến độ
var progress_x = canvas_x1;
var progress_y = canvas_y1 + canvas_h + 10;
var bar_w = canvas_w;
var bar_h = 12;

// Đếm pixel đã tô xấp xỉ bằng cách đo diện tích các vòng vẽ
// (Tiện: dùng biến pixels_painted được cập nhật ở Step)
var progress = clamp(pixels_painted / total_pixels, 0, 1);

// Nền thanh
draw_set_color(make_color_rgb(50, 50, 50));
draw_rectangle(progress_x, progress_y, progress_x + bar_w, progress_y + bar_h, false);

// Phần đã hoàn thành (gradient từ xanh lá sang vàng)
if (progress > 0) {
    var bar_color = merge_color(c_green, c_yellow, progress);
    draw_set_color(bar_color);
    draw_rectangle(progress_x, progress_y, progress_x + bar_w * progress, progress_y + bar_h, false);
}

// Viền thanh
draw_set_color(c_white);
draw_rectangle(progress_x, progress_y, progress_x + bar_w, progress_y + bar_h, true);

// Phần trăm
draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(progress_x + bar_w / 2, progress_y + bar_h / 2,
          string(floor(progress * 100)) + "% hoàn thành");

// 5) Hướng dẫn hoàn thành
var hint_txt = "Nhấn phím SPACE/ENTER hoặc nút XONG để nộp tranh | Lăn chuột để đổi nét cọ to nhỏ nhé!";
var hy = progress_y + bar_h + 40;
draw_set_color(c_black);
draw_text(canvas_x1 + canvas_w/2 - 1, hy, hint_txt);
draw_text(canvas_x1 + canvas_w/2 + 1, hy, hint_txt);
draw_set_color(c_ltgray);
draw_text(canvas_x1 + canvas_w/2, hy, hint_txt);

// 6) Cảnh báo nếu chưa đủ tiến độ
if (show_warning && warning_alpha > 0) {
    draw_set_alpha(warning_alpha);
    draw_set_color(c_red);
    draw_text(canvas_x1 + canvas_w/2, hy + 24, warning_text);
}

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
    
    var hover_done = (mx >= btn_done_x && mx <= btn_done_x + btn_done_w && my >= btn_done_y && my <= btn_done_y + btn_done_h);
    
    draw_set_color(hover_done ? c_lime : c_green);
    draw_roundrect(btn_done_x, btn_done_y, btn_done_x + btn_done_w, btn_done_y + btn_done_h, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_text(btn_done_x + btn_done_w/2, btn_done_y + btn_done_h/2, "XONG");
    
    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// 8) ANIMATION HOÀN THÀNH TRANH
if (variable_instance_exists(id, "is_finished") && is_finished) {
    finish_alpha = min(finish_alpha + 0.02, 1); // Tăng dần độ mờ
    
    // Nền tối full màn hình
    draw_set_color(c_black);
    draw_set_alpha(finish_alpha * 0.85);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    draw_set_alpha(finish_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (asset_get_index("Font1") != -1) {
        draw_set_font(Font1);
    }
    
    // Viền đen cho chữ nổi bật hơn
    var text_x = room_width / 2;
    var text_y = room_height / 2 - 30;
    
    // Tiêu đề
    draw_set_color(c_yellow);
    draw_text_transformed(text_x, text_y, "BỨC TRANH TUYỆT ĐẸP!", 1.5, 1.5, 0);
    
    // Dòng phụ
    draw_set_color(c_white);
    draw_text_transformed(text_x, text_y + 40, "Bạn muốn làm gì với bức tranh này?", 1, 1, 0);
    
    // --- VẼ 2 NÚT BẤM LỰA CHỌN ---
    if (finish_alpha >= 0.9) {
        var btn_w = 200;
        var btn_h = 60;
        var center_x = room_width / 2;
        var center_y = room_height / 2 + 50;
        
        var btn1_x = center_x - 220; // Trưng bày
        var btn2_x = center_x + 20;  // Bán
        var btn_y = center_y;
        
        var mx = mouse_x;
        var my = mouse_y;
        
        // Nút Trưng Bày (Xanh lá)
        var hover1 = (mx >= btn1_x && mx <= btn1_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
        draw_set_color(hover1 ? c_lime : c_green);
        draw_roundrect(btn1_x, btn_y, btn1_x + btn_w, btn_y + btn_h, false);
        draw_set_color(c_white);
        draw_text(btn1_x + btn_w/2, btn_y + btn_h/2, "TRƯNG BÀY");
        
        // Nút Bán (Cam/Vàng)
        var hover2 = (mx >= btn2_x && mx <= btn2_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
        draw_set_color(hover2 ? c_yellow : c_orange);
        draw_roundrect(btn2_x, btn_y, btn2_x + btn_w, btn_y + btn_h, false);
        draw_set_color(c_black);
        var sell_val = floor(current_progress * 200) + 50;
        draw_text(btn2_x + btn_w/2, btn_y + btn_h/2, "BÁN LẤY TIỀN (" + string(sell_val) + ")");
    }
    
    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}
