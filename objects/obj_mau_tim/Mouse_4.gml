// Mouse Left Pressed
if (!variable_global_exists("color_count")) {
    global.color_count = 0;
}
if (!variable_global_exists("current_palette")) {
    global.current_palette = [];
}

if (global.color_count < 6) {
    global.color_count += 1;
    array_push(global.current_palette, "tim"); // dung "tim" hay hardcode
    
    // Hien thi lo mau len ban cho truc quan
    var obj = -1;
    switch("tim") {
        case "do": obj = obj_mau_do; break;
        case "vang": obj = obj_mau_vang; break;
        case "xanh": obj = obj_mau_xanh; break;
        case "cam": obj = obj_cam; break;
        case "xanhla": obj = obj_xanhla; break;
        case "tim": obj = obj_tim; break;
    }
    if (obj != -1) {
        instance_create_layer(150 + global.color_count * 80, 460, "Color", obj);
    }
    
    // Am thanh click
    if (asset_get_index("snd_click") != -1) {
        audio_play_sound(snd_click, 1, false);
    }
}
