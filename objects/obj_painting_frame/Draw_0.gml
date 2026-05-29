// Draw Event for obj_painting_frame

// Chỉ vẽ nền trắng (tùy chọn) nếu muốn lót, nhưng stretch sẽ che hết nên không cần
// Khung gỗ đã có sẵn trên spr_gallery_background

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
    
    // Scale và stretch để khít hoàn toàn với viền lọt lòng của khung có sẵn
    draw_sprite_stretched(spr_painting, 0, x - frame_w/2, y - frame_h/2, frame_w, frame_h);
}

if (variable_instance_exists(id, "is_hovered") && is_hovered) {
    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(c_yellow);
    draw_text(x, y + frame_h/2 + 20, "[E] Xem chi tiết");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
