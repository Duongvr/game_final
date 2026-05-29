// Create Event for obj_gallery_controller

if (!variable_global_exists("saved_paintings")) {
    global.saved_paintings = [];
}
if (!variable_global_exists("paintings_hung")) {
    global.paintings_hung = 0;
}

var num_paintings = global.paintings_hung;

// 10 vị trí khung tranh có sẵn trên spr_gallery_background (kích thước 1536x1024)
// cx, cy: Tọa độ tâm khung; w, h: Kích thước lọt lòng của khung
var frame_configs = [
    {cx: 140,  cy: 440, w: 190, h: 125},
    {cx: 345,  cy: 430, w: 110, h: 150},
    {cx: 505,  cy: 440, w: 85,  h: 70},
    {cx: 595,  cy: 445, w: 45,  h: 40},
    {cx: 750,  cy: 440, w: 120, h: 90},
    {cx: 900,  cy: 440, w: 115, h: 140},
    {cx: 1025, cy: 445, w: 70,  h: 90},
    {cx: 1185, cy: 435, w: 190, h: 140},
    {cx: 1345, cy: 445, w: 90,  h: 70},
    {cx: 1455, cy: 450, w: 80,  h: 55}
];

for (var i = 0; i < num_paintings; i++) {
    var bg_index = i mod 10;
    var bg_offset_x = (i div 10) * 1536; // Background rộng 1536
    
    var conf = frame_configs[bg_index];
    var px = bg_offset_x + conf.cx;
    var py = conf.cy;
    
    var inst = instance_create_layer(px, py, "Instances", obj_painting_frame);
    
    // Gán kích thước lọt lòng để không vẽ đè lên viền gỗ của background
    inst.frame_w = conf.w;
    inst.frame_h = conf.h;
    
    if (i < array_length(global.saved_paintings)) {
        var data = global.saved_paintings[i];
        if (is_struct(data)) {
            inst.image_path = data.path;
            inst.p_name = data.name;
            inst.p_progress = data.progress;
            inst.p_value = data.value;
        } else {
            inst.image_path = data;
            inst.p_name = "Bức tranh " + string(i + 1);
            inst.p_progress = 0.5;
            inst.p_value = 100;
        }
    } else {
        inst.image_path = "";
        inst.p_name = "Tranh trống";
        inst.p_progress = 0.1;
        inst.p_value = 50;
    }
    
    inst.painting_id = i + 1;
    inst.array_index = i;
}

// Cập nhật lại giới hạn độ rộng của room dựa trên số lượng tranh (từng đoạn 1536)
var segments = (num_paintings == 0) ? 1 : ceil(num_paintings / 10);
room_width = max(1366, segments * 1536);
