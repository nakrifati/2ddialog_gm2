if global.dialog_state=false
{
image_angle=point_direction(x,y,mouse_x,mouse_y)
}
ls_light_set_pos(mouselight,x,y);

//if distance_to_object(target) > 5
//{
//move_towards_point(target.x,target.y,2.8)
//image_angle=point_direction(x,y,target.x,target.y)
//image_speed=0.4
//}
//image_xscale=-1

if keyboard_check_pressed(vk_lshift) 
{
actual_speed=4 
}

if keyboard_check_released(vk_lshift) 
{
actual_speed=8 
}

walk_speed=actual_speed+speed_bonus


if (cloth != -1)
{
speed_bonus = scr_get_item_value("hat", "speed_bonus");
}
else { speed_bonus = 0}

// timer
moment -=1/room_speed
if moment < 0
{
moment = 1
global.seconds -=1
}

if global.seconds < 0
{
global.seconds=59
global.minuts-=1
}

// hunger
//global.hp -=1/room_speed

