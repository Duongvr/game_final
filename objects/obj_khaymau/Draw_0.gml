// Draw Event for obj_khaymau
draw_self();

// Chinh xac dua tren kich thuoc spr_khaymau (360x179) va spr_mau (73x60)
var start_x = x + 36;
var start_y = y + 20;
var spacing_x = 108;
var spacing_y = 80;

if (!variable_global_exists("display_colors")) {
    global.display_colors = [spr_mau_do, spr_mau_vang, spr_mau_xanh];
}

for (var i = 0; i < array_length(global.display_colors); i++) {
    var col = i mod 3;
    var row = i div 3;
    
    // Toa do goc tren cung ben trai (vi sprite origin la 0,0)
    var px = start_x + col * spacing_x;
    var py = start_y + row * spacing_y;
    var spr = global.display_colors[i];
    
    // Tinh toan tam cua hinh tron mau
    var w = sprite_get_width(spr);
    var h = sprite_get_height(spr);
    var cx = px + w / 2;
    var cy = py + h / 2;
    
    // Vien trang nhe quanh mau de noi bat
    draw_set_color(c_white);
    draw_set_alpha(0.5);
    draw_circle(cx, cy, (w / 2) + 2, true);
    draw_set_alpha(1.0);
    
    // Ve sprite mau (Tai goc px, py)
    draw_sprite(spr, 0, px, py);
    
    // Xac dinh gia tri mau va ten mau
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
    
    // Hien thi vong vang va dau tick neu dang duoc chon
    var is_selected = false;
    
    if (variable_global_exists("phamau_state") && global.phamau_state == PhaMauState.MIXING_COLOR) {
        if (variable_global_exists("mixing_queue")) {
            for (var j = 0; j < array_length(global.mixing_queue); j++) {
                if (global.mixing_queue[j] == c_name) {
                    is_selected = true;
                    break;
                }
            }
        }
    } else {
        if (variable_global_exists("selected_color") && global.selected_color == c_val) {
            is_selected = true;
        }
    }
    
    if (is_selected) {
        draw_set_color(c_yellow);
        draw_circle(cx, cy, (w / 2) + 4, true);
        draw_circle(cx, cy, (w / 2) + 5, true);
        
        // Dau tick nho
        draw_set_color(c_lime);
        draw_line_width(cx - 6, cy + 1, cx, cy + 7, 2);
        draw_line_width(cx, cy + 7, cx + 9, cy - 5, 2);
    }
}

// Thong bao khi du 6 mau
if (array_length(global.display_colors) == 6) {
    draw_set_font(Font1); // Su dung font mac dinh
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x + sprite_width / 2, y - 10, "Đã pha đủ màu, sẵn sàng tô tranh!");
    
    // Reset lai can chinh de ko anh huong cho khac
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
