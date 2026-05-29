// Create Event for obj_palette_manager

// Xoa cac lo mau da dat cung trong phong (neu co)
with (obj_mau_do) instance_destroy();
with (obj_mau_vang) instance_destroy();
with (obj_mau_xanh) instance_destroy();
with (obj_mau_cam) instance_destroy();
with (obj_mau_xanhla) instance_destroy();
with (obj_mau_tim) instance_destroy();

// obj_khaymau se tu dong lo viec ve hien thi cac mau
// Khong can spawn object nua de tranh bi lech pixel va trung lap
