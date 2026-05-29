// Lấy tọa độ chuột thật trong Room
var mx = mouse_x;
var my = mouse_y;

// Kiểm tra xem chuột có nằm trong vùng Sprite không
is_hover = position_meeting(mx, my, id);

if (is_hover) {
    global.hover_active = true;
    if (mouse_check_button_pressed(mb_left)) {
        if (!audio_is_playing(snd_bgm)) {
            audio_play_sound(snd_bgm, 100, true);
        }
        is_pressed = true;
    }
    if (mouse_check_button_released(mb_left) && is_pressed) {
        is_pressed = false;
        // Chuyển sang room game chính
        room_goto(room_game);
    }
} else {
    is_pressed = false;
}
