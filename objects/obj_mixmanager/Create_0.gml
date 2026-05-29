/// @description Khởi tạo State Machine và Biến
enum PhaMauState {
    EXTRACT_COLOR,
    MIXING_COLOR,
    CHOOSE_MODE
}

global.phamau_state = PhaMauState.EXTRACT_COLOR;
global.tray_colors = [];     
global.mixing_queue = [];
global.color_count = 0;
