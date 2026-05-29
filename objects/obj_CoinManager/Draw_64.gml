/// @description Vẽ số lượng tiền lên màn hình
var coin_text = "Coins: " + string(global.coins);
draw_set_color(c_black);
draw_text(22, 22, coin_text);
draw_set_color(c_yellow);
draw_text(20, 20, coin_text);
draw_set_color(c_white);
