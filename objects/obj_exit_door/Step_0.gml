// Step Event for obj_exit_door

var is_near = false;
if (instance_exists(obj_main)) {
    if (point_distance(x, y, obj_main.x, obj_main.y) < 100) {
        is_near = true;
    }
}

// Nếu đứng gần và bấm E, quay về room_game
if (is_near && keyboard_check_pressed(ord("E"))) {
    room_goto(room_game);
}

show_prompt = is_near;
