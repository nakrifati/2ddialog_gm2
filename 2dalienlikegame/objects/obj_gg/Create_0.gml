shoot=true
walk_speed=8
speed_bonus=0
actual_speed=8
global.ammo=10
global.dialog_state=false
global.shoot_free=true

// inventory
instance_create(x,y,obj_inv_control)
instance_create(x,y,obj_items);

cloth = -1;

// gui
instance_create(x,y,obj_gui);
moment=1


ls_system_properties(true,ls_dm_normal,c_dkgray,true);
ls_noview_attach();
mouselight=ls_light_create(mouse_x,mouse_y,256,360,0,c_white,32,false,true,16);

with (obj_w_blocker)
{
    /*First we must create an empty shadow shape for the block,
      and say which way we will be defining the points.*/
    myshadow=ls_shadow_create(ls_ss_cw);
    
    /*Now we can actually add points to the shape.
      Subdivision will subdivide if the length is over
      the value specified. This helps with shadow artifacts
      if the shadows are too long, or the lights too small.*/
    var sW,sH;
     sW=sprite_width;
     sH=sprite_height;
    ls_shadow_addpoint_cartesian(myshadow,128,128,128);
    ls_shadow_addpoint_cartesian(myshadow,0,128,128);
    ls_shadow_addpoint_cartesian(myshadow,0,0,128);
    ls_shadow_addpoint_cartesian(myshadow,128,0,128);
    
    /*This last point that closes the shape is not needed. If you do not place
      it, the engine will place it for you. However, the engine does not use
    ls_shadow_addpoint_cartesian(myshadow,-sW,-sH,128);
    ls_shadow_addpoint_cartesian(myshadow,sW,-sH,128);
    ls_shadow_addpoint_cartesian(myshadow,sW,sH,128);
    ls_shadow_addpoint_cartesian(myshadow,-sW,sH,128);
      subdivision, which is what we want here, so we place it manually.*/
    //ls_shadow_addpoint_cartesian(myshadow,-sW,-sH,64);
    
    /*Now that we are done adding the points, we need to add the shape to the room!*/
    ls_shadow_attach_pos(myshadow,x,y,true);
    
    /*Note: In this engine we make a custom shape for every single object. You don't 
      have to do this, and in fact it is better if you don't. It is best to use the
      same shadow shape in multiple places if possible. However, since all these
      squares can be any size, we need to create a custom one for each.*/
}

/* */
/*  */
