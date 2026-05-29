// Step Event for obj_gallery
if (instance_exists(obj_main)) {
    if (distance_to_object(obj_main) < 100) {
        show_prompt = true;
        if (keyboard_check_pressed(ord("E"))) {
            room_goto(room_gallery);
        }
    } else {
        show_prompt = false;
    }
}
