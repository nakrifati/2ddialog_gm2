if global.shoot_free=true
{
{ if global.ammo > 0
{
instance_create(obj_gg.x,obj_gg.y,obj_bullet)
//sound_play(snd_shot)
global.ammo-=1
shoot = false
alarm[2]=4
}
}
}


