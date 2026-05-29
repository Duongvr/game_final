// ===== CANVAS =====
canvas_w = 700;
canvas_h = 382;

if (!instance_exists(obj_theme_board)) {
    instance_create_layer(0, 0, layer, obj_theme_board);
}

// Bắt buộc tải lại dữ liệu chủ đề mỗi khi vào vẽ tự do
if (instance_exists(obj_data_manager)) {
    instance_destroy(obj_data_manager);
}
instance_create_layer(0, 0, layer, obj_data_manager);

// Đảm bảo obj_GameManager luôn tồn tại dù người chơi test thẳng room
if (!instance_exists(obj_GameManager)) {
    instance_create_layer(0, 0, layer, obj_GameManager);
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

// ===== ECONOMY & RECEIPT =====
used_colors = [];
asking_theme = false;
show_receipt = false;
receipt_data = { g_cb: 0, s_m: 0, t_cd: 0, total: 0 };
