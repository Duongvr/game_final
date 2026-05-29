// Step Event
var mx = mouse_x;
var my = mouse_y;
is_hover = position_meeting(mx, my, id);

if (is_hover && mouse_check_button_pressed(mb_left)) {
    global.selected_color = my_color;
    target_scale = start_scale * 1.3;
    bounce_time = 10;
    if (asset_get_index("snd_click") != -1) {
        audio_play_sound(snd_click, 1, false);
    }
}

// Bounce back
if (bounce_time > 0) {
    bounce_time -= 1;
} else {
    target_scale = start_scale;
}

image_xscale = lerp(image_xscale, target_scale, 0.2);
image_yscale = lerp(image_yscale, target_scale, 0.2);
