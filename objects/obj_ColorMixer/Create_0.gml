/// @description Định nghĩa thuật toán pha màu
function mix_colors(_color1, _color2) {
    if (_color1 == _color2) return _color1;
    if ((_color1 == c_red && _color2 == c_yellow) || (_color1 == c_yellow && _color2 == c_red)) return c_orange;
    if ((_color1 == c_yellow && _color2 == c_blue) || (_color1 == c_blue && _color2 == c_yellow)) return c_green;
    if ((_color1 == c_red && _color2 == c_blue) || (_color1 == c_blue && _color2 == c_red)) return c_purple;
    return merge_color(_color1, _color2, 0.5);
}
