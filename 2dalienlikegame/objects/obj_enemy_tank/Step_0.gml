if k=0
{

if point_distance(x,y,obj_gg.x,obj_gg.y) < 1000
{

if hp>0
{
direction=point_direction(x,y,obj_gg.x,obj_gg.y)
image_angle=direction

if (reload>0) {reload-=1}
if (move>0) {move-=1}

if (distance_to_object(obj_gg)<=hunt and reload=0) {
//sound_play(hero_weap1)
//sprite_index=spr_inf_a
bullet=instance_create(x+lengthdir_x(10,direction),y+lengthdir_y(10,direction),obj_enemy_bullet)
bullet.speed=40
bullet.direction=direction
bullet.image_angle=bullet.direction
reload=20
move=20}

//if (hp<=0) {instance_destroy()}

image_speed=0.8
if spd >3
{
if road=0
{
//instance_create(x,y,obj_smoke)
}
}
}
if point_distance(x,y,obj_gg.x,obj_gg.y) > 500 then alarm[3]=1;
}


if (hp<=0) {
speed=0
sprite_index=spr_dead spd=0
}

}

if k=1
{
speed=0
image_angle=0
sprite_index=spr_dead
}

