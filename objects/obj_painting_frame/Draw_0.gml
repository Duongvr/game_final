// Draw Event for obj_painting_frame

// Vẽ khung gỗ
draw_set_color(make_color_rgb(101, 67, 33)); // Màu nâu gỗ
draw_rectangle(x - frame_w/2 - 10, y - frame_h/2 - 10, x + frame_w/2 + 10, y + frame_h/2 + 10, false);
draw_set_color(make_color_rgb(150, 100, 50)); // Màu nâu nhạt
draw_rectangle(x - frame_w/2 - 5, y - frame_h/2 - 5, x + frame_w/2 + 5, y + frame_h/2 + 5, false);
draw_set_color(c_white); // Nền trắng bên trong khung
draw_rectangle(x - frame_w/2, y - frame_h/2, x + frame_w/2, y + frame_h/2, false);

// Load hình ảnh nếu chưa load
if (!loaded && image_path != "") {
    if (file_exists(image_path)) {
        spr_painting = sprite_add(image_path, 1, false, false, 0, 0);
    }
    loaded = true;
}

// Vẽ bức tranh
if (sprite_exists(spr_painting)) {
    var sw = sprite_get_width(spr_painting);
    var sh = sprite_get_height(spr_painting);
    
    // Scale cho vừa khung
    var scale = min(frame_w / sw, frame_h / sh);
    
    var draw_w = sw * scale;
    var draw_h = sh * scale;
    
    // Vẽ căn giữa
    draw_sprite_ext(spr_painting, 0, x - draw_w/2, y - draw_h/2, scale, scale, 0, c_white, 1);
}

// Bảng tên
draw_set_color(c_dkgray);
draw_rectangle(x - 100, y + frame_h/2 + 15, x + 100, y + frame_h/2 + 45, false);
draw_set_color(c_white);
draw_rectangle(x - 100, y + frame_h/2 + 15, x + 100, y + frame_h/2 + 45, true);

if (asset_get_index("Font1") != -1) {
    draw_set_font(Font1);
}
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var title = variable_instance_exists(id, "p_name") ? p_name : "Bức tranh #" + string(painting_id);
draw_text(x, y + frame_h/2 + 30, title);

if (variable_instance_exists(id, "is_hovered") && is_hovered) {
    draw_set_color(c_yellow);
    draw_text(x, y + frame_h/2 + 65, "[E] Xem chi tiết   |   [B] Bán tranh (" + string(p_value) + " xu)");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
