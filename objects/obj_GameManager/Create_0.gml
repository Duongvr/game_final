/// @description Khởi tạo Trạng thái & Tiền tệ
enum GameState {
    DRAWING,
    SHOP,
    GALLERY
}
global.current_state = GameState.DRAWING;

if (!variable_global_exists("coins")) {
    global.coins = 130; 
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
    // Hiệu ứng đổ bóng cho tờ giấy
    draw_set_color(c_black);
    draw_set_alpha(0.15);
    draw_rectangle(px + 4, py + 4, px + pw + 6, py + ph + 6, false);
    draw_set_alpha(1);
    
    if (p_type == "white") {
        draw_set_color(c_white); // Trắng tinh
        draw_rectangle(px, py, px+pw, py+ph, false);
    } else if (p_type == "vintage") {
        draw_set_color(make_color_rgb(245, 230, 200));
        draw_rectangle(px, py, px+pw, py+ph, false);
        draw_set_color(make_color_rgb(215, 180, 130));
        for(var i=0; i<6; i++) draw_rectangle(px+i, py+i, px+pw-i, py+ph-i, true);
    } else if (p_type == "rainbow") {
        draw_rectangle_color(px, py, px+pw, py+ph, 
            make_color_rgb(255, 220, 220), make_color_rgb(255, 255, 220), 
            make_color_rgb(220, 255, 255), make_color_rgb(240, 220, 255), false);
    } else if (p_type == "grid") {
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
        draw_set_color(make_color_rgb(200, 220, 255)); // Lưới xanh nhạt chuẩn vở học sinh
        for(var i=0; i<pw; i+=30) draw_line(px+i, py, px+i, py+ph);
        for(var j=0; j<ph; j+=30) draw_line(px, py+j, px+pw, py+j);
    } else {
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
    }
    draw_set_color(c_white);
    draw_set_alpha(1);
}

global.draw_frame = function(px, py, pw, ph, f_type, fw) {
    var border = function(c, x, y, w, h, t) {
        // Đổ bóng 3D ngoài cho khung
        draw_set_alpha(0.3);
        draw_set_color(c_black);
        draw_rectangle(x-t+6, y-t+6, x+w+t+6, y+h+t+6, false);
        draw_set_alpha(1);
        
        // Nền khung gốc (Vẽ 4 cạnh để KHÔNG đè lên giấy ở giữa)
        draw_set_color(c);
        draw_rectangle(x-t, y-t, x+w+t, y, false); // Cạnh trên
        draw_rectangle(x-t, y+h, x+w+t, y+h+t, false); // Cạnh dưới
        draw_rectangle(x-t, y, x, y+h, false); // Cạnh trái
        draw_rectangle(x+w, y, x+w+t, y+h, false); // Cạnh phải
        
        // Highlight nổi 3D (Viền sáng góc trên-trái đón ánh sáng)
        var light_c = merge_color(c, c_white, 0.4);
        draw_set_color(light_c);
        draw_line_width(x-t, y-t, x+w+t, y-t, 4); // Cạnh trên
        draw_line_width(x-t, y-t, x-t, y+h+t, 4); // Cạnh trái
        
        // Shadow chìm 3D (Viền tối góc dưới-phải khuất sáng)
        var dark_c = merge_color(c, c_black, 0.4);
        draw_set_color(dark_c);
        draw_line_width(x-t, y+h+t, x+w+t, y+h+t, 4); // Cạnh dưới
        draw_line_width(x+w+t, y-t, x+w+t, y+h+t, 4); // Cạnh phải
        
        // Khoét nẹp lõm bên trong ép sát mặt giấy
        draw_set_color(dark_c);
        draw_rectangle(x, y, x+w, y+h, true);
        draw_rectangle(x+1, y+1, x+w-1, y+h-1, true);
    };

    if (f_type == "basic") {
        border(make_color_rgb(120, 70, 40), px, py, pw, ph, fw);
        // Vẽ thêm vân gỗ nghệ thuật mờ mờ
        draw_set_color(make_color_rgb(70, 35, 15));
        draw_set_alpha(0.4);
        for(var i=5; i<pw+fw; i+=30) {
            draw_line(px-fw+i, py-fw, px-fw+i+15, py);
            draw_line(px-fw+i, py+ph+fw, px-fw+i+15, py+ph);
        }
        draw_set_alpha(1);
    } else if (f_type == "daisy") {
        border(make_color_rgb(150, 240, 150), px, py, pw, ph, fw);
        for(var i=10; i<pw; i+=60) {
            draw_set_color(c_white); draw_circle(px+i, py-fw/2, 10, false); draw_circle(px+i, py+ph+fw/2, 10, false);
            draw_set_color(make_color_rgb(255, 200, 50)); draw_circle(px+i, py-fw/2, 5, false); draw_circle(px+i, py+ph+fw/2, 5, false);
        }
        for(var j=10; j<ph; j+=60) {
            draw_set_color(c_white); draw_circle(px-fw/2, py+j, 10, false); draw_circle(px+pw+fw/2, py+j, 10, false);
            draw_set_color(make_color_rgb(255, 200, 50)); draw_circle(px-fw/2, py+j, 5, false); draw_circle(px+pw+fw/2, py+j, 5, false);
        }
    } else if (f_type == "superman") {
        border(make_color_rgb(220, 20, 60), px, py, pw, ph, fw);
        draw_set_color(make_color_rgb(30, 144, 255)); 
        for(var i=0; i<pw+fw*2; i+=50) {
            draw_rectangle(px-fw+i, py-fw, px-fw+i+25, py-fw+10, false);
            draw_rectangle(px-fw+i, py+ph+fw-10, px-fw+i+25, py+ph+fw, false);
        }
        for(var j=0; j<ph+fw*2; j+=50) {
            draw_rectangle(px-fw, py-fw+j, px-fw+10, py-fw+j+25, false);
            draw_rectangle(px+pw+fw-10, py-fw+j, px+pw+fw, py-fw+j+25, false);
        }
    } else if (f_type == "sparkle") {
        border(make_color_rgb(255, 120, 200), px, py, pw, ph, fw);
        draw_set_color(make_color_rgb(255, 240, 100));
        var draw_diamond = function(cx, cy) {
            draw_primitive_begin(pr_trianglefan);
            draw_vertex(cx, cy-8); draw_vertex(cx+8, cy);
            draw_vertex(cx, cy+8); draw_vertex(cx-8, cy);
            draw_primitive_end();
        };
        for(var i=20; i<pw; i+=60) { draw_diamond(px+i, py-fw/2); draw_diamond(px+i, py+ph+fw/2); }
        for(var j=20; j<ph; j+=60) { draw_diamond(px-fw/2, py+j); draw_diamond(px+pw+fw/2, py+j); }
    } else {
        border(c_gray, px, py, pw, ph, fw);
    }
}

// ========================================
// PHÁT NHẠC NỀN LẶP ĐI LẶP LẠI (BGM)
// ========================================
if (!audio_is_playing(snd_bgm)) {
    // Tham số thứ 3 là "true" để báo cho GameMaker biết phải lặp lại vô tận
    audio_play_sound(snd_bgm, 100, true);
}
