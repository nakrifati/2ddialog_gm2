do
{
    //check there is no walls in the way
    mp_grid_add_instances(path,obj_w_blocker,true);
    //mp_grid_add_instances(path,obj_door_w,true);
    //look for a valid path
    check=mp_grid_path(grid,path,x,y,irandom(room_width),irandom(room_height),true); 
}
until (check) //until one is found//
    
path_start(path,moveRate,"",true); //begin moving along the newly found path//
