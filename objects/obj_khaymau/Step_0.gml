// Step Event for obj_khaymau

// Cap nhat mau vao khay dua tren nhung gi da chon
if (variable_global_exists("tray_colors")) {
    global.display_colors = [];
    for (var i = 0; i < array_length(global.tray_colors); i++) {
        var c_name = global.tray_colors[i];
        if (c_name == "do") array_push(global.display_colors, spr_mau_do);
        else if (c_name == "vang") array_push(global.display_colors, spr_mau_vang);
        else if (c_name == "xanh") array_push(global.display_colors, spr_mau_xanh);
        else if (c_name == "cam") array_push(global.display_colors, spr_cam);
        else if (c_name == "xanhla") array_push(global.display_colors, spr_xanhla);
        else if (c_name == "tim") array_push(global.display_colors, spr_tim);
    }
} else {
    global.display_colors = [];
}

// Chuc nang click de chon mau (dung cho room_tomau hoac MIXING_COLOR)
if (mouse_check_button_pressed(mb_left)) {
    var mx = mouse_x;
    var my = mouse_y;
    
    // Chinh xac dua tren kich thuoc spr_khaymau (360x179) va spr_mau (73x60)
    var start_x = x + 36;
    var start_y = y + 20;
    var spacing_x = 108;
    var spacing_y = 80;
    
    for (var i = 0; i < array_length(global.display_colors); i++) {
        var col = i mod 3;
        var row = i div 3;
        
        var px = start_x + col * spacing_x;
        var py = start_y + row * spacing_y;
        var spr = global.display_colors[i];
        
        var w = sprite_get_width(spr);
        var h = sprite_get_height(spr);
        var cx = px + w / 2;
        var cy = py + h / 2;
        
        // Kiem tra chuot co bam vao hinh tron cua mau nay ko
        if (point_distance(mx, my, cx, cy) < (w / 2)) {
            var c_val = c_white;
            var c_name = "";
            switch (spr) {
                case spr_mau_do: c_val = c_red; c_name = "do"; break;
                case spr_mau_vang: c_val = c_yellow; c_name = "vang"; break;
                case spr_mau_xanh: c_val = c_blue; c_name = "xanh"; break;
                case spr_cam: c_val = c_orange; c_name = "cam"; break;
                case spr_xanhla: c_val = c_lime; c_name = "xanhla"; break;
                case spr_tim: c_val = c_purple; c_name = "tim"; break;
            }
            
            // Neu dang pha mau o room_phamau
            if (variable_global_exists("phamau_state") && global.phamau_state == PhaMauState.MIXING_COLOR) {
                if (array_length(global.mixing_queue) < 2) {
                    array_push(global.mixing_queue, c_name);
                }
            } 
            // Nguoc lai neu dang o room_tomau
            else {
                global.selected_color = c_val;
            }
        }
    }
}
