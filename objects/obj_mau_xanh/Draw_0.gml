// Draw Event - Lo mau
var cx = x - (sprite_xoffset * image_xscale) + (sprite_width / 2);
var cy = y - (sprite_yoffset * image_yscale) + (sprite_height / 2);

// Vien trang nhe quanh mau de noi bat
draw_set_color(c_white);
draw_set_alpha(0.5);
draw_circle(cx, cy, (sprite_width / 2) + 3, true);
draw_set_alpha(1);

// Hieu ung phat sang vien khi hover chuot
if (is_hover) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y,
        image_xscale * 1.12, image_yscale * 1.12,
        image_angle, c_white, 0.4);
    gpu_set_blendmode(bm_normal);
}

draw_self();

// Hieu ung "da chon" vong vang
if (global.selected_color == my_color) {
    var t = current_time / 300;
    draw_set_color(c_yellow);
    draw_set_alpha(0.6 + sin(t) * 0.3);
    var radius = (sprite_width / 2) + 6 + sin(t * 2) * 2;
    draw_circle(cx, cy, radius, true);
    draw_circle(cx, cy, radius - 1, true);
    draw_set_alpha(1);

    // Dau tick mau xanh la
    draw_set_color(c_lime);
    draw_line_width(cx - 6,  cy + 1, cx,     cy + 7, 2);
    draw_line_width(cx,      cy + 7, cx + 9, cy - 5, 2);
}
