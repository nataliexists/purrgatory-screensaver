#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (controller) {
    apply_hueshift(rainbowEffect)
    var bgScale; bgScale = windowHeight/sprite_get_height(bg)
    draw_sprite_ext(
    bg, syncBeat mod 2,
    (windowWidth - (sprite_get_width(bg) * bgScale)) / 2, 0,
    bgScale, bgScale,
    0,
    c_white, 1)
    draw_rect(0, 0, windowWidth, windowHeight, c_white, max(0, bgBrightness), 0)
    draw_rect(0, 0, windowWidth, windowHeight, c_black, -min(0, bgBrightness), 0)
    shader_pixel_reset()
}
