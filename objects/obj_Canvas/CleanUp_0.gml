/// @description Giải phóng bộ nhớ
if (surface_exists(canvas_surface)) {
    surface_free(canvas_surface);
}
