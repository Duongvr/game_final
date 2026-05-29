// Create Event cho obj_main
move_speed = 4;

// Biến di chuyển
hsp = 0;
vsp = 0;

// Hướng mặt
facing = 1;
image_xscale = facing;

// Biến tương tác
near_gallery = false;
var lay_id = layer_get_id("Collision");
if (lay_id != -1) {
    collision_map = layer_tilemap_get_id(lay_id);
} else {
    collision_map = -1;
}