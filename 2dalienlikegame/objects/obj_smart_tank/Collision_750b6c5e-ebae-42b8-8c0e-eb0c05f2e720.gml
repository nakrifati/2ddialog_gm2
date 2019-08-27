with (other) {
action_kill_object();
}
hp-=20
if hp<=0
{
if live=true
{
live=false
mp_grid_clear_all(obj_gg)
path_speed=0
}
}

