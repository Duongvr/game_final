// Draw Event for obj_market
draw_self();

if (instance_exists(obj_main) && distance_to_object(obj_main) < 80) {
    var txt = "Nhấn E để mở Chợ";
    var tx = x;
    var ty = y - sprite_height / 2 - 20;
    
    draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Viền đen
    draw_set_color(c_black);
    draw_text(tx-1, ty, txt);
    draw_text(tx+1, ty, txt);
    draw_text(tx, ty-1, txt);
    draw_text(tx, ty+1, txt);
    
    // Chữ trắng
    draw_set_color(c_white);
    draw_text(tx, ty, txt);
}
