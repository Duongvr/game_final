/// @description Xử lý bán tranh
if (global.current_state == GameState.DRAWING) {
    global.coins += 50;
    with (obj_Canvas) {
        if (surface_exists(canvas_surface)) {
            surface_free(canvas_surface);
        }
    }
}
