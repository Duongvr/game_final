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
        if (dist < 1) dist = 1;

        for (var i = 0; i <= dist; i += 1) {
            var t = i / dist;
            var px = lerp(last_x, sx, t);
            var py = lerp(last_y, sy, t);

            draw_circle_color(
                px,
                py,
                brush_size,
                global.selected_color,
                global.selected_color,
                false
            );
        }
    }
    else {
        draw_circle_color(
            sx,
            sy,
            brush_size,
            global.selected_color,
            global.selected_color,
            false
        );
    }

    surface_reset_target();
    last_x = sx;
    last_y = sy;
    pixels_painted += pi * brush_size * brush_size * 0.05;
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
    if (hover_done) set_hand = true;
    
    if ((hover_done && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        is_finished = true; 
        current_progress = 1; // Free mode luôn coi là 100%
    }
}

// =====================================================
// XỬ LÝ LỰA CHỌN: TRƯNG BÀY HAY BÁN
// =====================================================
if (is_finished && finish_alpha >= 0.9) {
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
    
    if (hover1 || hover2) set_hand = true;
    
    if (mouse_check_button_pressed(mb_left)) {
        
        // --- CLICK NÚT TRƯNG BÀY ---
        if (hover1) {
            global.paintings_owned += 1;
            
            if (!variable_global_exists("paintings_hung")) {
                global.paintings_hung = 0;
            }
            global.paintings_hung += 1;
            
            if (!variable_global_exists("saved_paintings")) {
                global.saved_paintings = [];
            }
            
            var p_idx = array_length(global.saved_paintings) + 1;
            var file_name = "painting_" + string(p_idx) + "_" + string(current_time) + ".png";
            
            if (surface_exists(surf)) {
                surface_save(surf, file_name);
            }
            
            var painting_data = {
                path: file_name,
                progress: current_progress,
                name: "Bức tranh tự do " + string(p_idx),
                value: floor(min(pixels_painted / 500, 200)) + 50
            };
            
            array_push(global.saved_paintings, painting_data);
            window_set_cursor(cr_default);
            room_goto(room_game);
        }
        
        // --- CLICK NÚT BÁN LẤY TIỀN ---
        if (hover2) {
            if (!variable_global_exists("player_money")) global.player_money = 0;
            
            var sell_value = floor(min(pixels_painted / 500, 200)) + 50;
            global.player_money += sell_value;
            
            window_set_cursor(cr_default);
            room_goto(room_game);
        }
    }
}

// Cập nhật biểu tượng chuột (hình bàn tay)
if (set_hand) {
    window_set_cursor(cr_handpoint);
} else {
    window_set_cursor(cr_default);
}
