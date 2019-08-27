hp=40
//direction=choose(158,85,65,5,336)
spr_dead=spr_slot

//en1
moveRate = 2.25;//speed
vision = 250;//how far he can see
//create grid and add path
grid = mp_grid_create(0,0,room_width/4,room_height/4,4,4);
path=path_add();
contact=false
live=true

alarm[0] = 1;


