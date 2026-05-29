/// @description Khởi tạo Trạng thái & Tiền tệ
enum GameState {
    DRAWING,
    SHOP,
    GALLERY
}
global.current_state = GameState.DRAWING;

if (!variable_global_exists("coins")) {
    global.coins = 50; 
}

// Giả lập dữ liệu chủ đề
global.current_theme_name = "Đại Dương Xanh";
global.current_theme_desc = "Bé hãy vẽ các loài sinh vật biển nhé!";

// Biến lưu trữ lựa chọn nền và khung
global.selected_paper = "white"; // white, grid, vintage, rainbow
global.selected_frame = "basic"; // basic, daisy, superman, sparkle

// Kho đồ (các món đã mua)
if (!variable_global_exists("unlocked_items")) {
    global.unlocked_items = {
        paper_white: true,
        paper_grid: false,
        paper_vintage: false, 
        paper_rainbow: false,
        frame_basic: true,
        frame_daisy: false, 
        frame_superman: false,
        frame_sparkle: false
    };
}

global.draw_paper = function(px, py, pw, ph, p_type) {
    if (p_type == "white") {
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
    } else if (p_type == "vintage") {
        draw_set_color(make_color_rgb(240, 218, 177));
        draw_rectangle(px, py, px+pw, py+ph, false);
        draw_set_color(make_color_rgb(205, 170, 125));
        for(var i=0; i<4; i++) draw_rectangle(px+i, py+i, px+pw-i, py+ph-i, true);
    } else if (p_type == "rainbow") {
        draw_rectangle_color(px, py, px+pw, py+ph, 
            make_color_rgb(255, 200, 200), make_color_rgb(255, 255, 200), 
            make_color_rgb(200, 255, 255), make_color_rgb(220, 200, 255), false);
    } else if (p_type == "grid") {
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
        draw_set_color(make_color_rgb(210, 210, 210));
        for(var i=0; i<pw; i+=25) draw_line(px+i, py, px+i, py+ph);
        for(var j=0; j<ph; j+=25) draw_line(px, py+j, px+pw, py+j);
    } else {
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
    }
    draw_set_color(c_white);
    draw_set_alpha(1);
}

global.draw_frame = function(px, py, pw, ph, f_type, fw) {
    var border = function(c, x, y, w, h, t) {
        draw_set_color(c);
        draw_rectangle(x-t, y-t, x+w+t, y, false);
        draw_rectangle(x-t, y+h, x+w+t, y+h+t, false);
        draw_rectangle(x-t, y, x, y+h, false);
        draw_rectangle(x+w, y, x+w+t, y+h, false);
    };

    if (f_type == "basic") {
        border(make_color_rgb(90, 50, 20), px, py, pw, ph, fw);
        border(make_color_rgb(140, 80, 30), px, py, pw, ph, fw-5);
        draw_set_color(c_black); draw_rectangle(px-fw, py-fw, px+pw+fw, py+ph+fw, true);
    } else if (f_type == "daisy") {
        border(make_color_rgb(170, 255, 170), px, py, pw, ph, fw);
        draw_set_color(c_black); draw_rectangle(px-fw, py-fw, px+pw+fw, py+ph+fw, true);
        for(var i=10; i<pw; i+=50) {
            draw_set_color(c_white); draw_circle(px+i, py-fw/2, 8, false); draw_circle(px+i, py+ph+fw/2, 8, false);
            draw_set_color(c_yellow); draw_circle(px+i, py-fw/2, 4, false); draw_circle(px+i, py+ph+fw/2, 4, false);
        }
        for(var j=10; j<ph; j+=50) {
            draw_set_color(c_white); draw_circle(px-fw/2, py+j, 8, false); draw_circle(px+pw+fw/2, py+j, 8, false);
            draw_set_color(c_yellow); draw_circle(px-fw/2, py+j, 4, false); draw_circle(px+pw+fw/2, py+j, 4, false);
        }
    } else if (f_type == "superman") {
        border(make_color_rgb(220, 20, 60), px, py, pw, ph, fw);
        draw_set_color(make_color_rgb(30, 144, 255)); 
        for(var i=0; i<pw+fw*2; i+=40) {
            draw_rectangle(px-fw+i, py-fw, px-fw+i+20, py-fw+10, false);
            draw_rectangle(px-fw+i, py+ph+fw-10, px-fw+i+20, py+ph+fw, false);
        }
        for(var j=0; j<ph+fw*2; j+=40) {
            draw_rectangle(px-fw, py-fw+j, px-fw+10, py-fw+j+20, false);
            draw_rectangle(px+pw+fw-10, py-fw+j, px+pw+fw, py-fw+j+20, false);
        }
        draw_set_color(make_color_rgb(255, 215, 0)); 
        draw_rectangle(px-fw, py-fw, px+pw+fw, py+ph+fw, true);
        draw_rectangle(px, py, px+pw, py+ph, true);
    } else if (f_type == "sparkle") {
        border(make_color_rgb(255, 105, 180), px, py, pw, ph, fw);
        draw_set_color(c_yellow);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        for(var i=20; i<pw; i+=60) {
            draw_text(px+i, py-fw/2, "+"); draw_text(px+i, py+ph+fw/2, "+");
        }
        for(var j=20; j<ph; j+=60) {
            draw_text(px-fw/2, py+j, "+"); draw_text(px+pw+fw/2, py+j, "+");
        }
        draw_set_color(c_white); draw_rectangle(px-fw, py-fw, px+pw+fw, py+ph+fw, true);
        draw_set_halign(fa_left); draw_set_valign(fa_top);
    } else {
        draw_set_color(c_black); draw_rectangle(px-fw, py-fw, px+pw+fw, py+ph+fw, true);
    }
}
