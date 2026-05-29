/// @description Quản lý và Vẽ nét cọ lên Surface
if (!surface_exists(canvas_surface)) {
    canvas_surface = surface_create(canvas_width, canvas_height);
    surface_set_target(canvas_surface);
    draw_clear_alpha(c_white, 1);
    surface_reset_target();
}

if (global.current_state == GameState.DRAWING) {
    if (mouse_check_button(mb_left)) {
        if (mouse_x >= x && mouse_x <= x + canvas_width &&
            mouse_y >= y && mouse_y <= y + canvas_height) {
            surface_set_target(canvas_surface);
            var draw_x = mouse_x - x;
            var draw_y = mouse_y - y;
            draw_set_color(global.current_color);
            draw_circle(draw_x, draw_y, global.brush_size, false);
            draw_set_color(c_white);
            surface_reset_target();
        }
    }
}
draw_surface(canvas_surface, x, y);
