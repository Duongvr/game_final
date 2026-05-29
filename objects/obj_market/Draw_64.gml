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
    var ui_w = 640;
    var ui_h = 480;
    var ui_x = gw / 2 - ui_w / 2;
    var ui_y = gh / 2 - ui_h / 2;

    // Nền đen mờ
    draw_set_color(make_color_rgb(25, 20, 35));
    draw_set_alpha(0.95);
    draw_roundrect_ext(ui_x, ui_y, ui_x + ui_w, ui_y + ui_h, 25, 25, false);
    draw_set_alpha(1);

    // Viền vàng rực
    draw_set_color(make_color_rgb(255, 215, 0));
    for (var k = 0; k < 3; k++) {
        draw_roundrect_ext(ui_x - k, ui_y - k, ui_x + ui_w + k, ui_y + ui_h + k, 25, 25, true);
    }

    // Tiêu đề
    draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(gw / 2, ui_y + 30, "- CỬA HÀNG HỌA CỤ -", 1.4, 1.4, 0);

    // Thông tin tài nguyên nhỏ bên trong
    draw_set_color(c_white);
    draw_text(gw / 2, ui_y + 65, "Tài sản: " + string(global.coins) + " Xu   |   Tổng tranh đã vẽ: " + string(global.paintings_owned));

    // Đường kẻ ngang phân cách
    draw_set_color(make_color_rgb(80, 80, 100));
    draw_line(ui_x + 40, ui_y + 85, ui_x + ui_w - 40, ui_y + 85);

    // Dữ liệu mở khóa
    var unl = global.unlocked_items;
    var t_grid = unl.paper_grid ? "[ĐÃ MUA]" : "30 Xu";
    var t_vintage = unl.paper_vintage ? "[ĐÃ MUA]" : "50 Xu";
    var t_rainbow = unl.paper_rainbow ? "[ĐÃ MUA]" : "80 Xu";
    var t_daisy = unl.frame_daisy ? "[ĐÃ MUA]" : "100 Xu";
    var t_superman = unl.frame_superman ? "[ĐÃ MUA]" : "150 Xu";
    var t_sparkle = unl.frame_sparkle ? "[ĐÃ MUA]" : "200 Xu";

    var _menu_labels = [
        "Giấy Ô Vuông: " + t_grid,
        "Giấy Da Cổ Điển: " + t_vintage,
        "Giấy Cầu Vồng: " + t_rainbow,
        "Khung Hoa Cúc: " + t_daisy,
        "Khung Siêu Nhân: " + t_superman,
        "Khung Lấp Lánh: " + t_sparkle,
        "ĐÓNG CỬA HÀNG"
    ];

    for (var i = 0; i < 7; i++) {
        var item_y = ui_y + 125 + i * 45;
        var _lbl = _menu_labels[i];
        if (i == menu_index) {
            // Nền highlight
            draw_set_color(make_color_rgb(80, 60, 20));
            draw_set_alpha(0.8);
            draw_roundrect(ui_x + 30, item_y - 18, ui_x + ui_w - 30, item_y + 18, false);
            draw_set_alpha(1);

            draw_set_color(c_yellow);
            draw_text(gw / 2, item_y, ">> " + _lbl + " <<");
        } else {
            draw_set_color(c_ltgray);
            draw_text(gw / 2, item_y, _lbl);
        }
    }

    // Gợi ý phím bên dưới
    draw_set_color(make_color_rgb(140, 140, 140));
    draw_text(gw / 2, ui_y + ui_h - 20, "[ Lên/Xuống ] Di chuyển   [ Space/Enter ] Chọn   [ E ] Đóng");
}

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
