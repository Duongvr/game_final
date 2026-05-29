// Draw GUI Event cho obj_main
var popup_open = false;
if (instance_exists(obj_painting_frame)) {
    with (obj_painting_frame) {
        if (variable_instance_exists(id, "show_detail") && show_detail) {
            popup_open = true;
        }
    }
}

var txt = "";

if (!popup_open) {
    var obj_pt = asset_get_index("obj_phongtranh");
    var obj_gal = asset_get_index("obj_gallery");
    var obj_mk = asset_get_index("obj_market");
    var obj_exit = asset_get_index("obj_exit_door");

    if (obj_pt != -1 && instance_exists(obj_pt) && distance_to_object(obj_pt) < 100) {
        txt = "Nhấn [E] để vẽ tranh";
    } else if (obj_gal != -1 && instance_exists(obj_gal) && distance_to_object(obj_gal) < 100) {
        txt = "Nhấn [E] để vào Phòng Trưng Bày";
    } else if (obj_mk != -1 && instance_exists(obj_mk) && distance_to_object(obj_mk) < 80) {
        txt = "Nhấn [E] để mở Chợ";
    } else if (obj_exit != -1 && instance_exists(obj_exit) && distance_to_object(obj_exit) < 100) {
        txt = "Nhấn [E] để ra ngoài";
    }
}

if (txt != "") {
    var gw = display_get_gui_width();
    var tx = gw / 2;
    var ty = display_get_gui_height() - 60;

    if (asset_get_index("Font1") != -1) draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Bảng đen làm nền cho chữ nổi bật
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_roundrect(tx - string_width(txt)/2 - 20, ty - 20, tx + string_width(txt)/2 + 20, ty + 20, false);
    draw_set_alpha(1);

    // Chữ vàng
    draw_set_color(c_yellow);
    draw_text(tx, ty, txt);

    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
