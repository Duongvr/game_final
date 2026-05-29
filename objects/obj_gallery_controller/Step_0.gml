// Step Event for obj_gallery_controller
if (keyboard_check_pressed(vk_escape)) {
    room_goto(room_game);
}

// Logic thoát khỏi phòng bằng cách đến gần cửa (vị trí spawn ban đầu)
door_x = 100;
door_y = 650;
near_door = false;

if (instance_exists(obj_main)) {
    if (point_distance(obj_main.x, obj_main.y, door_x, door_y) < 120) {
        near_door = true;
        if (keyboard_check_pressed(ord("E"))) {
            room_goto(room_game);
        }
    }
}
