// ===== CANVAS =====
canvas_w = 700;
canvas_h = 382;

if (!instance_exists(obj_theme_board)) {
    instance_create_layer(0, 0, layer, obj_theme_board);
}

// ===== SURFACE =====
surf = surface_create(canvas_w, canvas_h);

surface_set_target(surf);
draw_clear_alpha(c_white, 0);
surface_reset_target();

// ===== BRUSH =====
brush_size = 12;

// ===== DRAW SMOOTH =====
last_x = -1;
last_y = -1;

// ===== PROGRESS =====
pixels_painted = 0;

// ===== FINISH ANIMATION =====
is_finished = false;
finish_alpha = 0;
finish_timer = 0;

depth = -9999; // Đưa object lên tầng cao nhất để không bị che khuất UI hoàn thành
