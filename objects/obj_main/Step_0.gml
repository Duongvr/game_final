// ======================
// INPUT
// ======================
var right = keyboard_check(vk_right);
var left  = keyboard_check(vk_left);
var up    = keyboard_check(vk_up);
var down  = keyboard_check(vk_down);

// ======================
// MOVEMENT & LẬT ẢNH (Chống giật lùi)
// Chặn di chuyển nếu Market UI đang mở
// ======================
var _market_open = false;
if (instance_exists(obj_market)) {
    _market_open = obj_market.show_ui;
}

var _h_input = right - left;
var _v_input = 0;

if (!_market_open) {
    if (room == room_gallery) {
        _v_input = 0; // Khóa di chuyển dọc trong gallery
    } else {
        _v_input = down - up;
    }
}

if (_h_input != 0 && !_market_open) {
    var _new_facing = sign(_h_input);
    if (facing != _new_facing) {
        facing = _new_facing;
        hsp = 0; // Bỏ qua di chuyển trong 1 frame để chống giật lùi
    } else {
        hsp = _h_input * move_speed;
    }
} else {
    hsp = 0;
}

vsp = _v_input * move_speed;


// Giới hạn biên nghiêm ngặt (Strict Boundary)
var _half_w = sprite_width / 2;
var _half_h = sprite_height / 2;
x = clamp(x, _half_w, room_width - _half_w);
y = clamp(y, _half_h, room_height - _half_h);

image_xscale = facing;

// ======================
// ANIMATION
// ======================
if (hsp != 0 || vsp != 0) {
    image_speed = 1;
} else {
    image_speed = 0;
    image_index = 0;
}

// ======================
// VÀO PHÒNG TRANH (Nhấn E khi đứng cạnh)
// ======================
near_gallery = false;
if (instance_exists(obj_phongtranh) && distance_to_object(obj_phongtranh) < 100) {
    near_gallery = true;
}

if (near_gallery && !_market_open) {
    if (keyboard_check_pressed(ord("E"))) {
        room_goto(room_phamau);
    }
}
// Horizontal
var can_move_h = true;
if (collision_map != -1) {
    if (tilemap_get_at_pixel(collision_map, x + hsp, y) != 0 || 
        tilemap_get_at_pixel(collision_map, x + hsp, y + 12) != 0) {
        can_move_h = false;
    }
}
if (can_move_h) x += hsp;

// Vertical
var can_move_v = true;
if (collision_map != -1) {
    if (tilemap_get_at_pixel(collision_map, x, y + vsp) != 0 || 
        tilemap_get_at_pixel(collision_map, x + 8, y + vsp) != 0) {
        can_move_v = false;
    }
}
if (can_move_v) y += vsp;