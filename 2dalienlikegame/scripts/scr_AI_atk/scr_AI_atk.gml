//The en prioritize nearest player, instead of latest created player. 
var nearestEn = instance_nearest(x,y,obj_gg);

if(!collision_line(x, y, nearestEn.x, nearestEn.y, obj_w_blocker, 0, 1))//check for walls blocking view
{ 
    if(distance_to_object(instance_nearest(x,y, obj_gg))<vision)//find the nearest instance and check distance is within vision length
    {   
        if(instance_exists(obj_gg))//check that instance exists
        { 
            alarm[1] = 5;//Increase vision so the enemy gets slightly longer field of view
            nearest_enemy=instance_nearest(x,y,obj_gg)//set nearest x and y 
            //add things to move around                   
            mp_grid_add_instances(path,obj_w_blocker,true);
            //set the target point and move towards it
            mp_grid_path(grid,path,x,y,nearest_enemy.x,nearest_enemy.y,true);
            path_start(path,moveRate,"",true);     
        }          
    }    
}
