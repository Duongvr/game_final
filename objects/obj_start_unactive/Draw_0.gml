// Vẽ nút Start to lên khi di chuột vào và nhỏ đi khi nhấn
var scale = 1.0;
if (is_pressed) {
    scale = 0.95;
} else if (is_hover) {
    scale = 1.05;
}

draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, image_angle, image_blend, image_alpha);
