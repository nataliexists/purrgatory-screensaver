#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
update_window()
dt = get_delta() / 1000000
timer = sound_get_pos(musicInst, unit_seconds)
frame += 1

if (frame == 1) {
    window_set_fullscreen(true)
}
if (frame == 2) {
    repeat ((windowWidth * windowHeight) div 7200) {
        with (instance_create(0, 0, bubble)) {
            x = random(windowWidth)
            y = random(windowHeight)
        }
    }
}

var curBeat;
curBeat = floor(timer / (60/tempo))

if (curBeat != syncBeat) {
    beat_react()
    syncBeat = curBeat
}

if (syncBeat div 4 >= 8) rainbow = true

if (rainbow) {
    catScale = ease(animTimer, 0, 0.3, 0.8, 1, "EaseOutBack")
    bgBrightness = ease(animTimer, 0, 0.3, 10/100, -5/100, "Linear")
    with (bubble) {
        size = ease(other.animTimer, 0, 0.6, startSize + 0.25, startSize, "EaseOutElastic")
    }
} else {
    catScale = ease(animTimer, 0, 0.15, 1, 0.9, "EaseInSine")
    catScale = ease(animTimer, 0.15, 0.3, catScale, 1, "EaseOutSine")
    bgBrightness = -5/100
}

animTimer += dt
if (rainbow) rainbowEffect += 1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///spawn bubbles

if (instance_exists(bubble)) {
    while (bubbleTimer <= 0) {
        bubbleTimer += (17280 + 50000) / (windowWidth * windowHeight)
        instance_create(0, 0, bubble)
    }
    bubbleTimer -= dt
}
#define Keyboard_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (keyboard_lastkey != vk_f1)
    game_end()
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
game_end()
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
game_end()
#define Mouse_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
game_end()
#define Other_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
window_resize_buffer(480, 360, true, 0)

if (parameter_count() == 0) { game_end(); exit }
if (string_starts_with(parameter_string(1), "/c") or
    string_starts_with(parameter_string(1), "/C"))
{ game_end(); exit }

if (not file_exists("C:\Windows\purrgatory.wav") or false) {
    show_message('Place the file "purrgatory.wav" in "C:\Windows"!')
    game_end()
} else {
    sound_add_ext("C:\Windows\purrgatory.wav", 1, true, "music")
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///init
globalvar windowWidth, windowHeight, dt, timer, rainbow, frame;
timer = 0
dt = 0
rainbow = false
frame = 0

window_set_sizeable(true)
windowWidth = window_get_width()
windowHeight = window_get_height()
//update_globals()

sound_set_loop("music", 33.391, sound_get_length("music", unit_seconds), unit_seconds)
globalvar musicInst; musicInst = sound_loop("music")
syncBeat = 0

catScale = 1
animTimer = 999

bgBrightness = 1

rainbowEffect = 0

instance_create(0, 0, bgthing)

bubbleTimer = 0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///setup hueshift shader

global.hueshiftShader = shader_pixel_create_base64("
    eJxdkr1uE0EUhb+Z2SQGRawEpRGsRAMUFjaicENCQkFhCjArUSBFhhgRKcaWY/qx
    REfjRxjacZMngLQ8A63FY7Dozt0Yw65Ge+7Zc8/92TW2qn5XDzh89eTgJvAFMLaq
    LCAxBj4DTwGXQktPeOANIDoDHAMzoD8YTU6HUzJ2MenWazAaf/o4Yykum/z/1+Ts
    qHP0lucn76bjs/H7WXH35b3iWa/fK/ofBsfDaXE4Hk1OTofTotvqdFvdR53Ww3a7
    zQvYMuQB/N4y3t9bxvhY/IS35EE48N+FW8b4TXiX9Bf71a+fLdi/kHe3dSQP7vwv
    zhc1XtDIw0FaRe5hdU5jFQxYw663KLYJN8MWOKc6OYsMMrAeSjkLR5xrrvOOH15z
    jTeUNbby9K8hM8lH+JXU8eplvPbHwkDysmwnjeJGytcamTdU6xpuzV+RXmtsvaVM
    9XQ+Ui3xuwrOpHrSe+XtOk4+c+lH8qWeg+Aow3btKfOIvp59LvmbuzDJM/o7acfK
    beilRtB3WYpvrHGse73URTlzzb1WezeD6iW+3Jti7TPW3spp7q0al0HnFH+Z69+Z
    5PvKDurv5a9DZtlJGJqS/1X/gZ2NXWJp5N6x8lUFfwAcCZJz
")

/*
    SamplerState Sampler : register(s0);

    struct PS_INPUT {
        float4 position: POSITION0;
        float2 uv: TEXCOORD0;
        float4 color: COLOR;
    };

    struct PS_OUTPUT {
        float4 color: COLOR;
    };

    float3 rgb2hsv(float3 c) {
      float4 K = float4(0.f, -1.f / 3.f, 2.f / 3.f, -1.f);
      float4 p = c.g < c.b ? float4(c.bg, K.wz) : float4(c.gb, K.xy);
      float4 q = c.r < p.x ? float4(p.xyw, c.r) : float4(c.r, p.yzx);

      float d = q.x - min(q.w, q.y);
      float e = 1e-10;
      return float3(abs(q.z + (q.w - q.y) / (6.f * d + e)), d / (q.x + e), q.x);
    }

    float3 hsv2rgb(float3 c) {
      float4 K = float4(1.f, 2.f / 3.f, 1.f / 3.f, 3.f);
      float3 p = abs(frac(c.xxx + K.xyz) * 6.f - K.www);
      return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
    }

    uniform float amount = 0;

    PS_OUTPUT main(PS_INPUT input) {
        PS_OUTPUT output;

        float4 diffuse = tex2D(Sampler,input.uv) * input.color;

        float3 hsv = rgb2hsv(diffuse.rgb);
        hsv.x = fmod(hsv.x + amount, 1);

        output.color=float4(hsv2rgb(hsv), diffuse.a);

        return output;
    }

*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
apply_hueshift(rainbowEffect)
var actualCatScale;
actualCatScale = catScale /** (windowHeight/360)*/ * 0.5
draw_sprite_ext(cat, syncBeat mod 2, windowWidth/2, windowHeight/2, actualCatScale, actualCatScale, 0, c_white, 1)
shader_pixel_reset()

draw_set_font(font0)
draw_set_color(c_black)
//draw_text(0, 0, parameter_string(1))
draw_reset()
