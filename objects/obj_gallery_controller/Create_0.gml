// Create Event for obj_gallery_controller

if (!variable_global_exists("saved_paintings")) {
    global.saved_paintings = [];
}
if (!variable_global_exists("paintings_hung")) {
    global.paintings_hung = 0;
}

var num_paintings = global.paintings_hung;
var start_x = 300;
var start_y = 350;
var spacing = 800; // Khoảng cách giữa các tranh

for (var i = 0; i < num_paintings; i++) {
    var px = start_x + i * spacing;
    var inst = instance_create_layer(px, start_y, "Instances", obj_painting_frame);
    
    if (i < array_length(global.saved_paintings)) {
        var data = global.saved_paintings[i];
        if (is_struct(data)) {
            inst.image_path = data.path;
            inst.p_name = data.name;
            inst.p_progress = data.progress;
            inst.p_value = data.value;
        } else {
            // Fallback for older saves that were just strings
            inst.image_path = data;
            inst.p_name = "Bức tranh " + string(i + 1);
            inst.p_progress = 0.5;
            inst.p_value = 100;
        }
    } else {
        // Fallback nếu có treo tranh nhưng chưa kịp vẽ (vd hack/lỗi đếm)
        inst.image_path = "";
        inst.p_name = "Tranh trống";
        inst.p_progress = 0.1;
        inst.p_value = 50;
    }
    
    inst.painting_id = i + 1;
    inst.array_index = i;
}

// Cập nhật lại giới hạn độ rộng của room dựa trên số lượng tranh
var min_width = 1366;
var new_width = max(min_width, start_x + num_paintings * spacing + 400);
room_width = new_width;
