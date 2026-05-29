/// @description Vẽ UI con trỏ cọ
if (global.current_state == GameState.DRAWING) {
    draw_set_color(global.current_color);
    draw_circle(x, y, global.brush_size, false);
    draw_set_color(c_black);
    draw_circle(x, y, global.brush_size, true);
    draw_set_color(c_white);
}
