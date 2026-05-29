/// @description Lấy màu vàng vào khay
if (global.phamau_state == PhaMauState.EXTRACT_COLOR) {
    var da_co = false;
    for (var i = 0; i < array_length(global.tray_colors); i++) {
        if (global.tray_colors[i] == "vang") da_co = true; 
    }
    if (!da_co && array_length(global.tray_colors) < 3) {
        array_push(global.tray_colors, "vang");
    }
}