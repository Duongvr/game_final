// Draw GUI Event 窶・v蘯ｽ nﾃｺt v盻嬖 vi盻］ vﾃng + ch盻ｯ ti蘯ｿng Vi盻㏄

var bx = btn_x;
var by = btn_y;
var bw = btn_w;
var bh = btn_h;
var scale = is_pressed ? 0.96 : (is_hover ? 1.05 : 1.0);

// Scale quanh 
var sx = bw/2 * scale;
var sy = bh/2 * scale;

// === N盻N Nﾃ啜 ===
draw_set_alpha(1);
// Bﾃｳng ﾄ黛ｻ・
draw_set_color(make_color_rgb(0, 0, 0));
draw_set_alpha(0.35);
draw_roundrect_ext(bx - sx + 4, by - sy + 6,
                   bx + sx + 4, by + sy + 6, 10, 10, false);

// Thﾃ｢n nﾃｺt
draw_set_alpha(1);
draw_set_color(make_color_rgb(26, 18, 8));
draw_roundrect_ext(bx - sx, by - sy,
                   bx + sx, by + sy, 10, 10, false);

// === VI盻N VﾃNG NGOﾃI ===
draw_set_color(make_color_rgb(201, 165, 32));
draw_set_alpha(1);
draw_roundrect_ext(bx - sx, by - sy,
                   bx + sx, by + sy, 10, 10, true);

// Vi盻］ vﾃng sﾃ｡ng trong
draw_set_color(make_color_rgb(248, 232, 124));
draw_set_alpha(0.45);
draw_roundrect_ext(bx - sx + 5, by - sy + 5,
                   bx + sx - 5, by + sy - 5, 7, 7, true);

// === GLOW KHI HOVER ===
if (alpha_glow > 0.01) {
    draw_set_color(make_color_rgb(244, 200, 66));
    draw_set_alpha(alpha_glow * 0.18);
    draw_roundrect_ext(bx - sx - 6, by - sy - 6,
                       bx + sx + 6, by + sy + 6, 14, 14, false);
    draw_set_alpha(alpha_glow * 0.08);
    draw_roundrect_ext(bx - sx - 12, by - sy - 12,
                       bx + sx + 12, by + sy + 12, 18, 18, false);
}

// === ﾄ脆ｯ盻廸G K蘯ｺ TRANG TRﾃ・===
draw_set_alpha(0.7);
draw_set_color(make_color_rgb(201, 165, 32));
draw_line(bx - sx + 22, by - 14, bx + sx - 22, by - 14);
draw_line(bx - sx + 22, by + 14, bx + sx - 22, by + 14);

// Kim cﾆｰﾆ｡ng gi盻ｯa ﾄ柁ｰ盻拵g k蘯ｻ
draw_set_alpha(1);
draw_set_color(make_color_rgb(201, 165, 32));
var pts = [bx, by-18,  bx+5, by-14,  bx, by-10,  bx-5, by-14];
draw_primitive_begin(pr_trianglefan);
draw_vertex_color(bx,    by-18, c_yellow, 1);
draw_vertex_color(bx+5,  by-14, make_color_rgb(201,165,32), 1);
draw_vertex_color(bx,    by-10, c_yellow, 1);
draw_vertex_color(bx-5,  by-14, make_color_rgb(201,165,32), 1);
draw_primitive_end();

var pts2 = [bx, by+18,  bx+5, by+14,  bx, by+10,  bx-5, by+14];
draw_primitive_begin(pr_trianglefan);
draw_vertex_color(bx,    by+18, c_yellow, 1);
draw_vertex_color(bx+5,  by+14, make_color_rgb(201,165,32), 1);
draw_vertex_color(bx,    by+10, c_yellow, 1);
draw_vertex_color(bx-5,  by+14, make_color_rgb(201,165,32), 1);
draw_primitive_end();

// === Gﾃ鼎 TRANG TRﾃ・(4 gﾃｳc) ===
draw_set_alpha(1);
draw_set_color(make_color_rgb(201, 165, 32));
var corners = [
    [bx - sx + 10, by - sy + 10],
    [bx + sx - 10, by - sy + 10],
    [bx - sx + 10, by + sy - 10],
    [bx + sx - 10, by + sy - 10]
];
var signs = [
    [1, 1], [-1, 1], [1, -1], [-1, -1]
];
for (var i = 0; i < 4; i++) {
    var cx2 = corners[i][0];
    var cy2 = corners[i][1];
    var dx  = signs[i][0] * 12;
    var dy  = signs[i][1] * 12;
    draw_line(cx2, cy2, cx2 + dx, cy2);
    draw_line(cx2, cy2, cx2, cy2 + dy);
    draw_circle(cx2, cy2, 2.5, false);
}

// === CHỮ TIẾNG VIỆT ===
draw_set_alpha(1);
draw_set_font(Font1);

// Chữ nhỏ phía trên (tên game)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(248, 200, 160));
draw_set_alpha(0.85);
draw_text(bx, by - 22, "KHU VƯỜN SẮC MÀU");

// Chữ BẮT ĐẦU chính - vẽ 3 lớp để tạo hiệu ứng vàng đổ bóng
// Lớp bóng
draw_set_color(make_color_rgb(100, 70, 0));
draw_set_alpha(0.6);
draw_text_transformed(bx + 2, by + 4, "BẮT ĐẦU", 1.5, 1.5, 0);

// Lớp nền vàng đậm
draw_set_color(make_color_rgb(180, 130, 10));
draw_set_alpha(1);
draw_text_transformed(bx, by + 2, "BẮT ĐẦU", 1.5, 1.5, 0);

// Lớp chính vàng sáng
draw_set_color(make_color_rgb(255, 235, 100));
draw_set_alpha(1);
draw_text_transformed(bx, by, "BẮT ĐẦU", 1.5, 1.5, 0);

// Chữ nhỏ phía dưới
draw_set_alpha(0.75);
draw_set_color(make_color_rgb(201, 165, 32));
draw_text(bx, by + 26, ">> HƯỚNG DẪN <<");

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
