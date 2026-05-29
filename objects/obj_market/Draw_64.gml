// Draw GUI Event for obj_market

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// === HUD góc phải trên - Tiền & Tranh ===
draw_set_font(Font1);

// Nền mờ cho HUD
var hud_x = gw - 190;
var hud_y = 10;
draw_set_color(c_black);
draw_set_alpha(0.45);
draw_roundrect(hud_x - 8, hud_y - 4, gw - 8, hud_y + 82, false);
draw_set_alpha(1);

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_yellow);
draw_text(gw - 16, hud_y + 6,  "$ Tiền: " + string(global.money));
draw_set_color(c_white);
draw_text(gw - 16, hud_y + 30, "Tổng tranh đã vẽ: " + string(global.paintings_owned));
draw_text(gw - 16, hud_y + 54, "Đang trưng bày: " + string(global.paintings_hung));

// === UI Chợ ở giữa màn hình ===
if (show_ui) {
    var ui_w = 420;
    var ui_h = 320;
    var ui_x = gw / 2 - ui_w / 2;
    var ui_y = gh / 2 - ui_h / 2;

    // Nền đen mờ
    draw_set_color(make_color_rgb(10, 10, 20));
    draw_set_alpha(0.88);
    draw_roundrect(ui_x, ui_y, ui_x + ui_w, ui_y + ui_h, false);
    draw_set_alpha(1);

    // Viền vàng
    draw_set_color(c_yellow);
    draw_roundrect(ui_x, ui_y, ui_x + ui_w, ui_y + ui_h, true);

    // Tiêu đề
    draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_yellow);
    draw_text(gw / 2, ui_y + 28, "=== CHỢ ===");

    // Thông tin tài nguyên nhỏ bên trong
    draw_set_color(c_white);
    draw_text(gw / 2, ui_y + 58, "Tiền: " + string(global.money) + " $   |   Tổng tranh đã vẽ: " + string(global.paintings_owned));

    // Đường kẻ ngang phân cách
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_line(ui_x + 20, ui_y + 74, ui_x + ui_w - 20, ui_y + 74);

    // Các mục menu
    if (!variable_global_exists("unlocked_frames")) global.unlocked_frames = [true, false, false];
    if (!variable_global_exists("unlocked_bgs")) global.unlocked_bgs = [true, false];

    var t_khung_go = global.unlocked_frames[1] ? "[ĐÃ MUA]" : "50 $";
    var t_khung_vang = global.unlocked_frames[2] ? "[ĐÃ MUA]" : "150 $";
    var t_bg_nham = global.unlocked_bgs[1] ? "[ĐÃ MUA]" : "100 $";

    var _menu_labels = [
        "Khung Gỗ: " + t_khung_go,
        "Khung Vàng: " + t_khung_vang,
        "Giấy Nhám: " + t_bg_nham,
        "Đóng Cửa Hàng"
    ];
    for (var i = 0; i < 4; i++) {
        var item_y = ui_y + 108 + i * 48;
        var _lbl = _menu_labels[i];
        if (i == menu_index) {
            // Nền highlight
            draw_set_color(make_color_rgb(60, 50, 10));
            draw_set_alpha(0.7);
            draw_roundrect(ui_x + 16, item_y - 16, ui_x + ui_w - 16, item_y + 16, false);
            draw_set_alpha(1);

            draw_set_color(c_yellow);
            draw_text(gw / 2, item_y, "> " + _lbl + " <");
        } else {
            draw_set_color(c_ltgray);
            draw_text(gw / 2, item_y, _lbl);
        }
    }

    // Gợi ý phím bên dưới
    draw_set_color(make_color_rgb(140, 140, 140));
    draw_text(gw / 2, ui_y + ui_h - 18, "[ ↑↓ ] Di chuyển   [ Space/Enter ] Chọn   [ E ] Đóng");
}

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
