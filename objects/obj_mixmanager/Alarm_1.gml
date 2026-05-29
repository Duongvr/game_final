// Alarm 1 Event for obj_mixmanager

if (spawn_index < 3) {
    var c_name = spawn_queue[spawn_index];
    var obj = noone;
    if (c_name == "cam") obj = obj_cam;
    if (c_name == "xanhla") obj = obj_xanhla;
    if (c_name == "tim") obj = obj_tim;
    
    if (obj != noone) {
        var pos_start = 150 + (3 + spawn_index) * 80;
        instance_create_layer(pos_start, 460, "Color", obj);
    }
    
    if (asset_get_index("snd_click") != -1) audio_play_sound(snd_click, 1, false);
    
    spawn_index += 1;
    alarm[1] = 25; // Spawn tiep sau 25 frames
} else {
    // Da spawn du 3 mau (tong 6 mau)
    alarm[0] = 50; // Doi mot chut roi chuyen phong
}
