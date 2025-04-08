#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (irandom(1)) {
    x = windowWidth + 200
    y = random_range(-windowHeight/2, windowHeight)
} else {
    y = -200
    x = random_range(0, windowWidth * 1.5)
}

direction = random_range(180 + 30, 270 - 30)
speed = random_range(0.5, 4.0)
image_angle = random(360)
image_index = irandom(6)
rotSpeed = random_range(-4, 4)
image_blend = make_color_hsv(irandom(255), 46, 255)

size = random_range(0.25, 1)
startSize = size
image_speed = 0

myTimer = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_angle += rotSpeed

if (x < -200 or y > windowHeight + 200) instance_destroy()
if (myTimer <= 0 and image_index != 6) { image_index = irandom(5); myTimer = 0.35898634}

myTimer -= dt

image_xscale = size * 0.5
image_yscale = size * 0.5
