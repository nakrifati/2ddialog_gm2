if distance_to_object(obj_gg) < 100
{
if open=false
{
alarm[0]=1
}

if open=true
{
if place_meeting(x,y,obj_gg) = false
{
alarm[1]=1
}
}
}

