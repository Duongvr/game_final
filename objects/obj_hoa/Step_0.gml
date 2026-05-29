// STEP EVENT - obj_tranh

var canvas_x1 = x;
var canvas_y1 = y;

var mx = mouse_x;
var my = mouse_y;

// =====================================================
// KIỂM TRA CHUỘT TRONG CANVAS
// =====================================================

var in_canvas = (
    mx >= canvas_x1 &&
    mx < canvas_x1 + canvas_w &&
    my >= canvas_y1 &&
    my < canvas_y1 + canvas_h
);

// =====================================================
// TÔ MÀU
// =====================================================

if (mouse_check_button(mb_left) && in_canvas) {

    // Chuyển tọa độ chuột sang surface
    var sx = mx - canvas_x1;
    var sy = my - canvas_y1;

    // Nếu surface bị mất thì tạo lại
    if (!surface_exists(surf)) {

        surf = surface_create(canvas_w, canvas_h);

        surface_set_target(surf);
        draw_clear_alpha(c_white, 0);
        surface_reset_target();
    }

    // =================================================
    // VẼ LÊN SURFACE
    // =================================================

    surface_set_target(surf);

    draw_set_alpha(1);

    // =================================================
    // TÔ MƯỢT
    // =================================================

    if (last_x != -1) {
        var dist = point_distance(last_x, last_y, sx, sy);

        if (dist > 0) {
            pixels_painted += dist * brush_size * 1.5;

            for (var i = 0; i <= dist; i += 1) {
                var t = i / dist;
                var px = lerp(last_x, sx, t);
                var py = lerp(last_y, sy, t);

                draw_circle_color(px, py, brush_size, global.selected_color, global.selected_color, false);
            }
        }
    }
    else {
        pixels_painted += pi * brush_size * brush_size;

        draw_circle_color(sx, sy, brush_size, global.selected_color, global.selected_color, false);
    }

    surface_reset_target();

    // =================================================
    // LƯU VỊ TRÍ CUỐI
    // =================================================

    last_x = sx;
    last_y = sy;

    
    // TRACK COLOR
    var c_sel = global.selected_color;
    var found = false;
    for (var j = 0; j < array_length(used_colors); j++) {
        if (used_colors[j] == c_sel) { found = true; break; }
    }
    if (!found) array_push(used_colors, c_sel);
}
else {

    last_x = -1;
    last_y = -1;
}

// =====================================================
// ĐỔI KÍCH THƯỚC BÚT
// =====================================================

if (keyboard_check(vk_down) || mouse_wheel_down()) {
    brush_size = max(2, brush_size - 1);
}

if (keyboard_check(vk_up) || mouse_wheel_up()) {
    brush_size = min(64, brush_size + 1);
}

// =====================================================
// HOÀN THÀNH BỨC TRANH & KIỂM TRA HOVER (CON TRỎ)
// =====================================================

var set_hand = false;

if (!is_finished) {
    // Tọa độ nút Xong
    var btn_done_w = 120;
    var btn_done_h = 40;
    var btn_done_x = canvas_x1 + canvas_w - btn_done_w;
    var btn_done_y = canvas_y1 + canvas_h + 10;
    
    var hover_done = (mx >= btn_done_x && mx <= btn_done_x + btn_done_w && my >= btn_done_y && my <= btn_done_y + btn_done_h);
    if (hover_done) global.hover_active = true;
    
    if ((hover_done && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        var progress = clamp(pixels_painted / total_pixels, 0, 1);
        
        if (progress >= 0.3) { // Hoàn thành ít nhất 30%
            is_finished = true; // Kích hoạt UI hoàn thành
            current_progress = progress; // Lưu tạm tiến độ
        } else {
            show_warning = true;
            warning_alpha = 1;
            warning_text = "Bạn cần vẽ thêm trước khi hoàn thành!";
        }
    }
}

// =====================================================
// XỬ LÝ LỰA CHỌN: TRƯNG BÀY HAY BÁN
// =====================================================
if (is_finished && finish_alpha >= 0.9) {
    if (show_receipt) {
        var btn_w = 120;
        var btn_h = 40;
        var btn_x = room_width / 2 - btn_w / 2;
        var btn_y = room_height / 2 + 100;
        var hover_done = (mx >= btn_x && mx <= btn_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
        if (hover_done) global.hover_active = true;
        if (hover_done && mouse_check_button_pressed(mb_left)) {
            global.coins += receipt_data.total;
            room_goto(room_game);
        }
    } else if (asking_theme) {
        var btn_w = 150;
        var btn_h = 50;
        var center_x = room_width / 2;
        var center_y = room_height / 2 + 50;
        
        var btn1_x = center_x - 170; // CÓ
        var btn2_x = center_x + 20;  // KHÔNG
        
        var hover1 = (mx >= btn1_x && mx <= btn1_x + btn_w && my >= center_y && my <= center_y + btn_h);
        var hover2 = (mx >= btn2_x && mx <= btn2_x + btn_w && my >= center_y && my <= center_y + btn_h);
        
        if (hover1 || hover2) global.hover_active = true;
        
        if (mouse_check_button_pressed(mb_left)) {
            if (hover1 || hover2) {
                var t = clamp(current_progress, 0, 1);
                var g_cb = 100 * t;
                var s_m = array_length(used_colors);
                var d_m = s_m * 10;
                var t_cd = hover1 ? 50 : 0;
                var total = floor(g_cb + d_m + t_cd);
                
                receipt_data = { g_cb: floor(g_cb), s_m: d_m, t_cd: t_cd, total: total };
                show_receipt = true;
                asking_theme = false;
            }
        }
    } else {
        // Tọa độ và kích thước 2 nút
        var btn_w = 200;
        var btn_h = 60;
        var center_x = room_width / 2;
        var center_y = room_height / 2 + 50;
        
        var btn1_x = center_x - 220; // Nút Trưng bày
        var btn2_x = center_x + 20;  // Nút Bán
        var btn_y = center_y;
        
        var hover1 = (mx >= btn1_x && mx <= btn1_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
        var hover2 = (mx >= btn2_x && mx <= btn2_x + btn_w && my >= btn_y && my <= btn_y + btn_h);
        
        if (hover1 || hover2) global.hover_active = true;
        
        if (mouse_check_button_pressed(mb_left)) {
            
            // --- CLICK NÚT TRƯNG BÀY ---
            if (hover1) {
                global.paintings_owned += 1;
                
                if (!variable_global_exists("paintings_hung")) global.paintings_hung = 0;
                global.paintings_hung += 1;
                
                if (!variable_global_exists("saved_paintings")) global.saved_paintings = [];
                
                var p_idx = array_length(global.saved_paintings) + 1;
                var file_name = "painting_" + string(p_idx) + "_" + string(current_time) + ".png";
                
                if (surface_exists(surf)) {
                    var final_surf = surface_create(canvas_w, canvas_h);
                    surface_set_target(final_surf);
                    
                    // 1) Vẽ nền giấy
                    if (variable_global_exists("draw_paper") && variable_global_exists("selected_paper")) {
                        global.draw_paper(0, 0, canvas_w, canvas_h, global.selected_paper);
                    } else {
                        draw_clear_alpha(c_white, 1);
                    }
                    
                    // 2) Vẽ nét đã tô
                    draw_surface(surf, 0, 0);
                    
                    // 3) Vẽ nét viền tranh (obj_net_tranh)
                    if (instance_exists(obj_net_hoa)) {
                        var inst = instance_find(obj_net_hoa, 0);
                        var draw_x = inst.x - x;
                        var draw_y = inst.y - y;
                        draw_sprite_ext(inst.sprite_index, inst.image_index, draw_x, draw_y, inst.image_xscale, inst.image_yscale, inst.image_angle, inst.image_blend, inst.image_alpha);
                    }
                    
                    // 4) Vẽ khung tranh (dịch vào trong để không bị cắt khỏi surface)
                    if (variable_global_exists("draw_frame") && variable_global_exists("selected_frame")) {
                        var fw = 20;
                        global.draw_frame(fw, fw, canvas_w - fw*2, canvas_h - fw*2, global.selected_frame, fw);
                    }
                    
                    surface_reset_target();
                    
                    surface_save(final_surf, file_name);
                    surface_free(final_surf);
                }
                
                var estimated_val = floor(current_progress * 100) + array_length(used_colors) * 10 + 50;
                
                var painting_data = {
                    path: file_name,
                    progress: current_progress,
                    name: "Bức tranh " + string(p_idx),
                    value: estimated_val
                };
                
                array_push(global.saved_paintings, painting_data);
                room_goto(room_game);
            }
            
            // --- CLICK NÚT BÁN LẤY TIỀN ---
            if (hover2) {
                var t = clamp(current_progress, 0, 1);
                var g_cb = 100 * t;
                var s_m = array_length(used_colors);
                var d_m = s_m * 10;
                var t_cd = 0; // Không tính chủ đề
                var total = floor(g_cb + d_m + t_cd);
                
                receipt_data = { g_cb: floor(g_cb), s_m: d_m, t_cd: t_cd, total: total };
                show_receipt = true;
            }
        }
    }
}


// Giảm mờ dần cảnh báo
if (show_warning && warning_alpha > 0) {
    warning_alpha -= 0.02;
}