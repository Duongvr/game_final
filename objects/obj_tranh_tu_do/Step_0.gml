// STEP EVENT - obj_tranh_tu_do

var canvas_x1 = x;
var canvas_y1 = y;

var mx = mouse_x;
var my = mouse_y;

var in_canvas = (
    mx >= canvas_x1 &&
    mx < canvas_x1 + canvas_w &&
    my >= canvas_y1 &&
    my < canvas_y1 + canvas_h
);

if (mouse_check_button(mb_left) && in_canvas) {

    var sx = mx - canvas_x1;
    var sy = my - canvas_y1;

    if (!surface_exists(surf)) {
        surf = surface_create(canvas_w, canvas_h);
        surface_set_target(surf);
        draw_clear_alpha(c_white, 0);
        surface_reset_target();
    }

    surface_set_target(surf);
    draw_set_alpha(1);

    if (last_x != -1) {
        var dist = point_distance(last_x, last_y, sx, sy);
        
        if (dist > 0) {
            pixels_painted += dist * brush_size * 1.5; // Area covered by stroke
            
            for (var i = 0; i <= dist; i += 1) {
                var t = i / dist;
                var px = lerp(last_x, sx, t);
                var py = lerp(last_y, sy, t);

                draw_circle_color(px, py, brush_size, global.selected_color, global.selected_color, false);
            }
        }
    }
    else {
        pixels_painted += pi * brush_size * brush_size; // Initial click area
        
        draw_circle_color(sx, sy, brush_size, global.selected_color, global.selected_color, false);
    }

    surface_reset_target();
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
        if (pixels_painted > 500) {
            is_finished = true; 
            current_progress = 1; // Free mode luôn coi là 100%
        } else {
            msg_text = "Tranh vẫn còn trống, bé hãy vẽ thêm nhé!";
            msg_timer = 120;
        }
    }
}

if (!variable_instance_exists(id, "msg_text")) {
    msg_text = "";
    msg_timer = 0;
}
if (msg_timer > 0) msg_timer--;
else msg_text = "";

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
                var t = clamp(pixels_painted / 150000, 0, 1);
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
                    
                    if (variable_global_exists("draw_paper") && variable_global_exists("selected_paper")) {
                        global.draw_paper(0, 0, canvas_w, canvas_h, global.selected_paper);
                    } else {
                        draw_clear_alpha(c_white, 1);
                    }
                    
                    draw_surface(surf, 0, 0);
                    
                    if (variable_global_exists("draw_frame") && variable_global_exists("selected_frame")) {
                        var fw = 20;
                        global.draw_frame(fw, fw, canvas_w - fw*2, canvas_h - fw*2, global.selected_frame, fw);
                    }
                    
                    surface_reset_target();
                    surface_save(final_surf, file_name);
                    surface_free(final_surf);
                }
                
                var t = clamp(pixels_painted / 150000, 0, 1);
                var estimated_value = floor(100 * t) + array_length(used_colors) * 10 + 50;
                
                var painting_data = {
                    path: file_name,
                    progress: current_progress,
                    name: "Bức tranh tự do " + string(p_idx),
                    value: estimated_value
                };
                
                array_push(global.saved_paintings, painting_data);
                room_goto(room_game);
            }
            
            // --- CLICK NÚT BÁN LẤY TIỀN ---
            if (hover2) {
                asking_theme = true;
            }
        }
    }
}


