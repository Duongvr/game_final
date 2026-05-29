// Khởi tạo thông tin
prices = {
    paper_white: 0,
    paper_grid: 0,
    paper_vintage: 0,
    paper_rainbow: 20,
    
    frame_basic: 0,
    frame_daisy: 0,
    frame_superman: 50,
    frame_sparkle: 100
};

papers = ["white", "grid", "vintage", "rainbow"];
paper_names = ["Trắng trơn", "Kẻ ô vuông", "Da cổ điển", "Cầu vồng"];
frames = ["basic", "daisy", "superman", "sparkle"];
frame_names = ["Gỗ cơ bản", "Hoa cúc", "Siêu nhân", "Lấp lánh"];

// Fallback (for testing room directly)
if (!variable_global_exists("selected_paper")) global.selected_paper = "white";
if (!variable_global_exists("selected_frame")) global.selected_frame = "basic";
if (!variable_global_exists("coins")) global.coins = 200;
if (!variable_global_exists("unlocked_items")) {
    global.unlocked_items = {
        paper_white: true, paper_grid: true, paper_vintage: true, paper_rainbow: false,
        frame_basic: true, frame_daisy: true, frame_superman: false, frame_sparkle: false
    };
}

// Lựa chọn tạm thời
temp_paper = global.selected_paper;
temp_frame = global.selected_frame;

// Method vẽ danh sách
draw_list = function(title, items, names, current_sel, sx, sy, mx, my, clicked, is_paper) {
    draw_set_color(c_white);
    draw_text(sx, sy - 40, title);
    
    var res_sel = current_sel;
    
    for (var i = 0; i < array_length(items); i++) {
        var itm = items[i];
        var iname = names[i];
        
        var bx = sx - 100;
        var by = sy + i * 65;
        var bw = 200;
        var bh = 55;
        
        var is_hover = (mx >= bx && mx <= bx + bw && my >= by && my <= by + bh);
        
        var key = is_paper ? ("paper_" + itm) : ("frame_" + itm);
        var is_unlocked = variable_struct_exists(global.unlocked_items, key) ? global.unlocked_items[$ key] : false;
        var price = is_paper ? prices[$ "paper_"+itm] : prices[$ "frame_"+itm];
        
        if (current_sel == itm) {
            draw_set_color(make_color_rgb(100, 220, 100)); 
        } else if (!is_unlocked) {
            draw_set_color(make_color_rgb(150, 150, 150)); 
        } else if (is_hover) {
            draw_set_color(make_color_rgb(220, 220, 255)); 
        } else {
            draw_set_color(make_color_rgb(240, 240, 240)); 
        }
        
        draw_roundrect(bx, by, bx + bw, by + bh, false);
        draw_set_color(c_black);
        draw_roundrect(bx, by, bx + bw, by + bh, true);
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_black);
        
        if (!is_unlocked) {
            draw_text(bx + bw/2, by + bh/2 - 10, iname);
            draw_set_color(c_red);
            draw_text_transformed(bx + bw/2, by + bh/2 + 10, "[KHÓA]", 0.8, 0.8, 0);
        } else {
            draw_text(bx + bw/2, by + bh/2, iname);
        }
        
        if (is_hover) {
            global.hover_active = true;
            if (clicked && is_unlocked) {
                res_sel = itm;
            }
        }
    }
    
    return res_sel;
};
