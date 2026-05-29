// Ki盻ノ tra va ch蘯｡m v盻嬖 obj_phongtranh
target = instance_place(obj_main.x, obj_main.y, obj_phongtranh);

if (target != noone)
{
    show = true;

    // Nh蘯･n E ﾄ黛ｻ・vﾃo phﾃｲng
    if (keyboard_check_pressed(ord("E")))
    {
        room_goto(room_phamau);
    }
}
else
{
    show = false;
}
