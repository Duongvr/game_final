// Create Event for obj_khaymau

// Xoa cac lo mau da dat cung trong phong de tranh trung lap
with (obj_mau_do) instance_destroy();
with (obj_mau_vang) instance_destroy();
with (obj_mau_xanh) instance_destroy();
with (obj_mau_cam) instance_destroy();
with (obj_mau_xanhla) instance_destroy();
with (obj_mau_tim) instance_destroy();

// Khoi tao mang mau hien thi
if (!variable_global_exists("display_colors")) {
    global.display_colors = [];
}
