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
draw_text(gw - 16, hud_y + 6,  "$ Xu: " + string(global.coins));
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
    draw_text(gw / 2, ui_y + 58, "Xu: " + string(global.coins) + " $   |   Tổng tranh đã vẽ: " + string(global.paintings_owned));

    // Đường kẻ ngang phân cách
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_line(ui_x + 20, ui_y + 74, ui_x + ui_w - 20, ui_y + 74);

    // Các mục menu
    var has_grid = variable_struct_exists(global.unlocked_items, "paper_grid") ? global.unlocked_items.paper_grid : false;
    var has_rainbow = variable_struct_exists(global.unlocked_items, "paper_rainbow") ? global.unlocked_items.paper_rainbow : false;
    var has_daisy = variable_struct_exists(global.unlocked_items, "frame_daisy") ? global.unlocked_items.frame_daisy : false;
    var has_superman = variable_struct_exists(global.unlocked_items, "frame_superman") ? global.unlocked_items.frame_superman : false;

    var t_grid = has_grid ? "[ĐÃ MUA]" : "50 Xu";
    var t_rainbow = has_rainbow ? "[ĐÃ MUA]" : "100 Xu";
    var t_daisy = has_daisy ? "[ĐÃ MUA]" : "120 Xu";
    var t_superman = has_superman ? "[ĐÃ MUA]" : "200 Xu";

    var _menu_labels = [
        "Giấy Ô Vuông: " + t_grid,
        "Giấy Cầu Vồng: " + t_rainbow,
        "Khung Hoa Cúc: " + t_daisy,
        "Khung Siêu Nhân: " + t_superman,
        "Đóng Cửa Hàng"
    ];
    for (var i = 0; i < 5; i++) {
        var item_y = ui_y + 108 + i * 40;
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
