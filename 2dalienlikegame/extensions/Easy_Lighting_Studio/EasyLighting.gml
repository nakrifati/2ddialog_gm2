#define ls_system_init
/* --- Before creating .gex, remove all these comments!
    Variables:
        __ls_surface_final -> Holds list of surfaces. Usually only 1, but you can add views so it needs one per view.
        
        __ls_draw_mode  -> 0 = dull, 1 = normal, 2 = extra vivid (CHECK CONSTANTS)
        __ls_isenabled  -> Toggles the lighting system.
        __ls_ambient    -> Ambient background color
        __ls_shadowcaps -> Whether or not to draw caps over shadow objects.
        
        __ls_list_light_properties -> Holds a list of list id's for each light. Properties in the contained
                                      list are as follows (NOTE: id's of their LISTS are passed as the light id!).
                                      Values:
                                            x
                                            y
                                            radius
                                            spread
                                            rot
                                            precision
                                            static
                                            surfaceid -> Not an argument, creates a surface for the light.
                                            
        __ls_list_shadow_shapes -> Holds a list of grids, each grid holding position of each point in polar coords. 
        __ls_list_shadow_positions -> Holds ds_lists that contain x,y, and shadowshape ID.
        
        __ls_penumbra_s -> holds ID of imported sprite that is the penumbra.
        
        NOTICE: Values stored in __ls_list_shadow_shapes are +- by 1 (depending on sign)!
                This is to avoid an index of 0.
                
        NOTICE2: Variables preceded by YYC_* are only there to work around YYC glitches.
*/
globalvar __ls_surface_finals,__ls_attached_views;
    __ls_surface_finals=ds_list_create();
    __ls_attached_views=ds_list_create();
globalvar __ls_draw_mode,__ls_isenabled,__ls_ambient,__ls_shadowcaps;
    __ls_draw_mode=ls_dm_normal;
    __ls_isenabled=false;
    __ls_ambient=c_black;
    __ls_shadowcaps=true;
    
globalvar __ls_list_light_properties;
    __ls_list_light_properties=ds_list_create();
    
globalvar __ls_list_shadow_shapes,__ls_list_shadow_positions;
    __ls_list_shadow_shapes=ds_list_create();
    __ls_list_shadow_positions=ds_list_create();
ds_grid_create(1,1);
globalvar __ls_penumbra_s,__ls_debug;
__ls_debug=false;
if (file_exists(temp_directory+"\\penumbra_s.png"))
    __ls_penumbra_s=sprite_add(temp_directory+"\\penumbra_s.png",0,0,0,0,0);
else
    __ls_penumbra_s=sprite_add(working_directory+"\\penumbra_s.png",0,0,0,0,0);
    
    
globalvar __ls_shapecustom;
__ls_shapecustom=ds_grid_create(6,5);//We will use 5 for padding every time it is resized.
ds_grid_clear(__ls_shapecustom,-1);

#define ls_system_free
/*
    Clears the entire system. Should be called at the end of the game.
*/
var size=ds_list_size(__ls_surface_finals);
for (var i=0;i<size;++i)
{
    surface_free(ds_list_find_value(__ls_surface_finals,i));
}
ds_list_destroy(__ls_surface_finals);
var size=ds_list_size(__ls_list_light_properties);
for (var i=0;i<size;++i)
{
    var p=ds_list_find_value(__ls_list_light_properties,i);
    surface_free(ds_list_find_value(p,ds_list_size(p)-1));
    surface_free(ds_list_find_value(p,ds_list_size(p)-4));
    ds_list_destroy(ds_list_find_value(__ls_list_light_properties,i));
}
ds_list_destroy(__ls_list_light_properties);
var size=ds_list_size(__ls_list_shadow_shapes);
for (var i=0;i<size;++i)
{
    ds_grid_destroy(abs(ds_list_find_value(__ls_list_shadow_shapes,i))-1);
}
ds_list_destroy(__ls_list_shadow_shapes);
ds_list_destroy(__ls_list_shadow_positions);
ds_list_destroy(__ls_attached_views);
sprite_delete(__ls_penumbra_s);

#define ls_system_clear
/*
    Will delete all lights, shadow attachments, shadow shapes, and viewport attachments.
*/
//Wipe the render surfaces.
var size=ds_list_size(__ls_surface_finals);
for (var i=0;i<size;++i)
{
    surface_free(ds_list_find_value(__ls_surface_finals,i));
}
ds_list_clear(__ls_surface_finals);
//Clear the lights.
var size=ds_list_size(__ls_list_light_properties);
for (var i=0;i<size;++i)
{
    var p=ds_list_find_value(__ls_list_light_properties,i);
    surface_free(ds_list_find_value(p,ds_list_size(p)-1));
    surface_free(ds_list_find_value(p,ds_list_size(p)-4));
    ds_list_destroy(ds_list_find_value(__ls_list_light_properties,i));
}
ds_list_clear(__ls_list_light_properties);
//Wipe all the shadow shapes:
var size=ds_list_size(__ls_list_shadow_shapes);
for (var i=0;i<size;++i)
{
    ds_grid_destroy(abs(ds_list_find_value(__ls_list_shadow_shapes,i))-1);
}
ds_list_clear(__ls_list_shadow_shapes);
//Wipe the shadow positions:
var size=ds_list_size(__ls_list_shadow_positions);
for (var i=0;i<size;++i)
{
    ds_list_destroy(abs(ds_list_find_value(__ls_list_shadow_positions,i)));
}
ds_list_clear(__ls_list_shadow_positions);
ds_list_clear(__ls_attached_views);

#define ls_angledif
return ((((argument0 - argument1)%360)+540)%360) - 180;

#define ls_system_draw
/*
    Draws the actual surface onto the screen.
    argument0 - Update system
    argument1 - Debug
*/
if (!__ls_isenabled||ds_list_empty(__ls_attached_views)) exit;
__ls_debug=argument1;
if (argument0)
    __ls_system_update();
draw_set_alpha(1);
draw_set_color(c_white);
if (__ls_debug)/*Debug messages should go in here as well.*/
    draw_set_blend_mode(bm_normal);
else
{
    if (__ls_draw_mode>0)
        draw_set_blend_mode_ext(bm_dest_color,bm_src_color);
    else
        draw_set_blend_mode_ext(bm_dest_color,bm_zero);
}
    
var surfaces=ds_list_size(__ls_attached_views);
for (var i=0;i<surfaces;++i)
{
    var ID=ds_list_find_value(__ls_attached_views,i);
    if (ID==-1)
        draw_surface(ds_list_find_value(__ls_surface_finals,i),0,0);
    else
    {
        if (view_current==ID)
            draw_surface_ext(ds_list_find_value(__ls_surface_finals,i),__view_get( e__VW.XView, ID ),__view_get( e__VW.YView, ID ),1,1,0,c_white,1);
    }
    
}    
    
draw_set_blend_mode(bm_normal);

#define ls_system_properties
/*
    Arguments:
        0 - enabled
        1 - lighting mode (ls_dm_dull/normal/vivid)
        2 - ambient color
        3 - draws shadow caps
*/
__ls_isenabled=argument0;
__ls_draw_mode=argument1;
__ls_ambient=argument2;
__ls_shadowcaps=argument3;

#define ls_view_attach
/*
    Attachs a view to the system to draw on
    Argument is the view
*/
if (ds_list_find_index(__ls_attached_views,argument0)==-1)
{
    ds_list_add(__ls_attached_views,argument0);
    ds_list_add(__ls_surface_finals,surface_create(__view_get( e__VW.WView, argument0 ),__view_get( e__VW.HView, argument0 )));
    return true;
}
return false;

#define ls_view_detach
var index=ds_list_find_index(__ls_attached_views,argument0);
if (index!=-1)
{
    ds_list_delete(__ls_attached_views,index);
    surface_free(ds_list_find_value(__ls_surface_finals,index));
    ds_list_delete(__ls_surface_finals,index);
    return true;
}
return false;

#define ls_view_recalculate
/*
    Recalculates the surface sizes for each view. 
*/
var size=ds_list_size(__ls_attached_views);
if (size==0)
    return false;
for (var i=0;i<size;++i)
{
    var ID=ds_list_find_value(__ls_attached_views,i);
    if (ID>=0)
    {
        if (surface_exists(ds_list_find_value(__ls_surface_finals,i)))
            surface_free(ds_list_find_value(__ls_surface_finals,i));
        ds_list_replace(__ls_surface_finals,i,surface_create(__view_get( e__VW.WView, ID ),__view_get( e__VW.HView, ID )));
    }
    else
    {
        if (surface_exists(ds_list_find_value(__ls_surface_finals,i)))
            surface_free(ds_list_find_value(__ls_surface_finals,i));
        ds_list_replace(__ls_surface_finals,i,surface_create(room_width,room_height));
        
    }
}
/*Clear the remaining surfaces and change the values to -1 so they are
  not mixed up later on.*/
size=ds_list_size(__ls_list_light_properties);
for (var i=0;i<size;++i)
{
    var ID,s;
    ID=ds_list_find_value(__ls_list_light_properties,i);
    s=ds_list_find_value(ID,ds_list_size(ID)-4);
    if (surface_exists(s))
        surface_free(s);
    ds_list_replace(ID,ds_list_size(ID)-4,-1);
}
return true;

#define ls_noview_attach
/*
    Attaches a "noview" or the entire room to be drawn on on every view.
*/
if (ds_list_find_index(__ls_attached_views,-1)==-1)
{
    ds_list_add(__ls_attached_views,-1);
    ds_list_add(__ls_surface_finals,surface_create(room_width,room_height));
    return true;
}
return false;

#define ls_noview_detach
var index=ds_list_find_index(__ls_attached_views,-1);
if (index!=-1)
{
    ds_list_delete(__ls_attached_views,index);
    surface_free(ds_list_find_value(__ls_surface_finals,index));
    ds_list_delete(__ls_surface_finals,index);
    return true;
}
return false;

#define ls_light_create
/*Arguments
    x
    y
    radius
    spread
    rot
    color
    precision
    static
    shadows
    core radius
*/
if (argument[9]<0||argument[9]>argument[2])
{
    show_error(@"Lighting Studio Error:
---
Invalid value for light core radius: "+string(argument[9]),1);
return -1;
}
var lightid=ds_list_create();
for (var i=0;i<=9;++i)
    ds_list_add(lightid,argument[i]);   
ds_list_add(lightid,surface_create(argument[2]*2,argument[2]*2));//This will store the
//actual light, no shadows.
ds_list_add(lightid,true);//Whether or not a change was made to the light.
ds_list_add(lightid,true);//Visible or not
ds_list_add(lightid,surface_create(argument[2]*2,argument[2]*2));
ds_list_add(__ls_list_light_properties,lightid);
if (argument[7] == true)
    ls_light_surface_draw(lightid,1);
    
return lightid;

#define ls_light_destroy
/*
    Arguments:
    0 -> light id
    
    Returns:
    if deleting succeded.
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to destroy non-existing light: "+string(argument0),1);
    return false;
}
surface_free(ds_list_find_value(argument0,ds_list_size(argument0)-1));
ds_list_destroy(argument0);
ds_list_delete(__ls_list_light_properties,val);
return true;

#define ls_light_set_pos
/*Arguments
    0 - id
    1 - x
    2 - y
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
ds_list_replace(argument0,0,argument1);
ds_list_replace(argument0,1,argument2);

#define ls_light_set_rot
/*Arguments
    0 - id
    1 - rot
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
ds_list_replace(argument0,4,argument1);
ds_list_replace(argument0,ds_list_size(argument0)-3,true);//Says we need to update the light.

#define ls_light_set_static
/*Arguments
    0 - id
    1 - static
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
ds_list_replace(argument0,7,argument1);
if (argument1==true)
    ls_light_surface_draw(argument0);

#define ls_light_set_spread
/*Arguments
    0 - id
    1 - spread
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
ds_list_replace(argument0,3,argument1);
ds_list_replace(argument0,ds_list_size(argument0)-3,true);//Says we need to update the light.

#define ls_light_set_radius
/*Arguments
    0 - id
    1 - radius
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
//Creates a new surfaces for the light, since the radius changes.
var surface;
surface=ds_list_find_value(argument0,ds_list_size(argument0)-1);
surface_free(surface);
surface=ds_list_find_value(argument0,ds_list_size(argument0)-4);
surface_free(surface);
var rad;
rad=argument1;
surface=surface_create(rad*2,rad*2);
ds_list_replace(argument0,ds_list_size(argument0)-1,surface);
surface=surface_create(rad*2,rad*2);
ds_list_replace(argument0,ds_list_size(argument0)-4,surface);
ds_list_replace(argument0,2,argument1);
ds_list_replace(argument0,ds_list_size(argument0)-3,true);//Says we need to update the light.

#define ls_light_set_coreradius
/*Arguments
    0 - id
    1 - radius
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
if (argument1<0||argument1>ds_list_find_value(argument0,2))
{
    show_error(@"Lighting Studio Error:
---
Invalid value for light core radius: "+string(argument[9]),1);
return -1;
}
ds_list_replace(argument0,9,argument1);
ds_list_replace(argument0,ds_list_size(argument0)-3,true);//Says we need to update the light.

#define ls_light_set_color
/*Arguments
    0 - id
    1 - color
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
if (ls_light_get_static(argument0))
{
    show_error(@"Lighting Studio Error:
---
Cannot change static light: "+string(argument0),0);
}
ds_list_replace(argument0,5,argument1);

#define ls_light_set_shadows
/*Arguments
    0 - id
    1 - shadows on (bool)
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
ds_list_replace(argument0,8,argument1);

#define ls_light_set_visible
/*Arguments
    0 - id
    1 - visible (bool)
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
ds_list_replace(argument0,ds_list_size(argument0)-2,argument1);

#define ls_light_get_x
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,0);

#define ls_light_get_y
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,1);

#define ls_light_get_rot
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,4);

#define ls_light_get_static
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,7);

#define ls_light_get_spread
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,3);

#define ls_light_get_radius
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,2);

#define ls_light_get_coreradius
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,9);

#define ls_light_get_color
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,5);

#define ls_light_get_shadows
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,8);

#define ls_light_get_visible
/*Arguments
    0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to grab properties of non-existing light: "+string(argument0),1);
exit;
}
return ds_list_find_value(argument0,ds_list_size(argument0)-2);

#define ls_light_manual_update
/* 
    Updates a light manually.
    Argument 0 - id
*/
var val=ds_list_find_index(__ls_list_light_properties,argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to change non-existing light: "+string(argument0),1);
exit;
}
ls_light_surface_draw(argument0,1);

#define ls_light_surface_draw
/*
    Arguments:
    0 -> id
    1 -> update static light
*/
draw_set_alpha(1);
draw_set_color(c_white);
var surf=ds_list_find_value(argument[0],ds_list_size(argument[0])-1),
    rad=ds_list_find_value(argument[0],2),/*Radius of light*/
    dir=ds_list_find_value(argument[0],4),/*Direction*/
    sprd=ds_list_find_value(argument[0],3),/*Spread of the light*/
    prec=ds_list_find_value(argument[0],6),/*Precision*/
    corerad=ds_list_find_value(argument[0],9);/*Light core radius*/
    
/*If the surface was destroyed, recreate it.*/
var updated;
updated=argument[1];
if (!surface_exists(surf))
{
    surf=surface_create(rad*2,rad*2)
    ds_list_replace(argument[0],ds_list_size(argument[0])-1,surf);
    updated=true;
}
/*If static, and we don't need to update, we quit early.*/
if (ds_list_find_value(argument[0],7)&&!updated)
    return 0;
/*We first draw the light itself:*/
draw_set_blend_mode(bm_normal);
//The actual LIGHT surface, without shadows.
    var tsurf,up;
    tsurf=ds_list_find_value(argument[0],ds_list_size(argument[0])-4);
    up=false;
    
    if (tsurf==-1||!surface_exists(tsurf))
    {
        tsurf=surface_create(rad*2,rad*2);
        ds_list_replace(argument[0],ds_list_size(argument[0])-4,tsurf);
        up=true;
    }
//If we need to update the light, we do so.
if (ds_list_find_value(argument[0],ds_list_size(argument[0])-3)||up)
{
    //We tell the system that it updated.
    ds_list_replace(argument[0],ds_list_size(argument[0])-3,false);
    surface_set_target(tsurf);
    draw_clear(c_black);
    draw_primitive_begin_texture(pr_trianglestrip,sprite_get_texture(__ls_penumbra_s,0));
    
    var soft_edge=false;
    if (sprd<360)
        soft_edge=true;
    var CRx,CRy;
       
    draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2))*corerad,rad-sin(pi/180*(dir-sprd/2))*corerad,soft_edge,1,c_white,1);
    draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2))*rad,rad-sin(pi/180*(dir-sprd/2))*rad,soft_edge,0,c_black,1);
    for (var i=dir-sprd/2+sprd/prec;i<=dir+sprd/2-sprd/prec;i+=sprd/prec)
    {
        CRx=cos(pi/180*i)*corerad;
        CRy=-sin(pi/180*i)*corerad;
        draw_vertex_texture_color(rad+CRx,rad+CRy,0,1,c_white,1);
        draw_vertex_texture_color(rad+cos(pi/180*i)*rad,rad-sin(pi/180*i)*rad,0,0,c_black,1);
    }
    
    draw_vertex_texture_color(rad+cos(pi/180*(dir+sprd/2-sprd/prec))*corerad,rad-sin(pi/180*(dir+sprd/2-sprd/prec))*corerad,0,1,c_white,1);
    draw_vertex_texture_color(rad+cos(pi/180*(dir+sprd/2-sprd/prec))*rad,rad-sin(pi/180*(dir+sprd/2-sprd/prec))*rad,0,0,c_black,1);
    
    if (!soft_edge)
    {
        draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2))*corerad,rad-sin(pi/180*(dir-sprd/2))*corerad,0,1,c_white,1);
        draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2))*rad,rad-sin(pi/180*(dir-sprd/2))*rad,0,0,c_black,1);
    }
    else
        draw_vertex_texture_color(rad+cos(pi/180*(dir+sprd/2))*rad,rad-sin(pi/180*(dir+sprd/2))*rad,soft_edge,0,c_black,1);
    draw_primitive_end();
    
    //Draw the center core:
    if (corerad>0)
    {
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(rad,rad,c_white,1);
        for (var i=dir-sprd/2;i<=dir+sprd/2;i+=sprd/prec)
        {
            if ((i!=dir-sprd/2&&i!=dir+sprd/2)||!soft_edge)
                draw_vertex_color(rad+cos(pi/180*i)*corerad,rad-sin(pi/180*i)*corerad,c_white,1);
        }
        draw_primitive_end();
    }
    surface_reset_target();
}
surface_set_target(surf);
/*Now we need to draw the stencil shadows:*/
draw_clear(c_black);
draw_surface(tsurf,0,0);/*Draw the light onto it.*/
var size=ds_list_size(__ls_list_shadow_positions),/*The number of shadows we need to consider*/
    light_x=ds_list_find_value(argument[0],0),
    light_y=ds_list_find_value(argument[0],1),
    _shads=ds_list_find_value(argument[0],8);/*Whether or not there are shadows enabled.*/
if (_shads)
for (var i=0;i<size;++i)
{
    /*Cullling on contains the ID of the position. If negative, that
      means that there is culling.*/
    var cullingon=ds_list_find_value(__ls_list_shadow_positions,i);
    var ID=abs(ds_list_find_value(abs(cullingon),0)),
        X=ds_list_find_value(abs(cullingon),1),
        Y=ds_list_find_value(abs(cullingon),2);
    cullingon=-sign(cullingon);/*Now 1=on, -1=off*/
    var points=ds_grid_height(ID)-1;
    /*
        Handles disabling shadows from drawing outside the light:
        
        We draw the shape if at least one point is inside the light.
    */
    var drawthings=false;
    for (j=0;j<points;++j)
    {
        var pt=ds_grid_get(ID,0,j),
            pr=ds_grid_get(ID,1,j);
        if (point_distance(light_x,light_y,X+cos(pi/180*pt)*pr,Y-sin(pi/180*pt)*pr)<=rad*1.5)
        {
            drawthings=true;
            break;
        }
    }
    
    /*These will tell from where to where to draw the shadows.*/
    var direc=1;
    
    /*If it isn't found, then it is a negative ID. This means
      we flip the culling direction*/
    if (ds_list_find_index(__ls_list_shadow_shapes,ID+1)==-1)
        direc=-1;
       
    var points_todraw=ds_list_create();
    /*If we have culling, we need to adjust lmost and rmost.*/
    if (cullingon&& drawthings)
    {
        var last_px,last_py,direc_tot=0;
           
        /*We grab the first point in the list and start the loop at the next.*/ 
        last_px=X+cos(pi/180*ds_grid_get(ID,0,0))*ds_grid_get(ID,1,0);
        last_py=Y-sin(pi/180*ds_grid_get(ID,0,0))*ds_grid_get(ID,1,0);
        
        var skipfirst=true;
        for (var j=1;j!=1||skipfirst;j=(j+1)%points)
        {
            skipfirst=false;
            var pt,pr,px,py,ff;
            
                pt=ds_grid_get(ID,0,j);
                pr=ds_grid_get(ID,1,j);
                px=X+cos(pi/180*pt)*pr;
                py=Y-sin(pi/180*pt)*pr;
                /*front facing: if ff>0 then we should draw the face.
                  We grab a normal of the lines, then do a dot product 
                  towards the light. Which normal depends on whether
                  clockwise or counter*/
            if (direc==-1)
                ff=sign(dot_product(-(py-last_py),px-last_px,px-light_x,py-light_y));
            else
                ff=sign(dot_product(py-last_py,-(px-last_px),px-light_x,py-light_y));
           
            if (ff==1)
                ds_list_add(points_todraw,j);
            last_px=px;
            last_py=py;
        }
    }
    else
    {
        for (var j=0;j<points;++j)
            ds_list_add(points_todraw,j);
    }
    
    
    
    /*Draw stuffs.*/
    var pt_f=ds_grid_get(ID,0,0),
        pr_f=ds_grid_get(ID,1,0);
    var rep__=0;
    repeat (1+__ls_debug)
    {
        var __color=c_black;
        if (rep__==0)
            draw_primitive_begin(pr_trianglelist);
        if (rep__==1)
        {
            __color=c_red;
            draw_primitive_begin(pr_linelist);
        }
            
        for (j=0;j<points;++j)
        {
            if (!drawthings) break;
            var jx=j-1;
            if (jx<0)
                jx+=points;
                
            var pt=ds_grid_get(ID,0,j),
                pr=ds_grid_get(ID,1,j),
                pt_p=ds_grid_get(ID,0,jx),
                pr_p=ds_grid_get(ID,1,jx);
            var dir=point_direction(light_x,light_y,X+cos(pi/180*pt)*pr,Y-sin(pi/180*pt)*pr),
                dir_p=point_direction(light_x,light_y,X+cos(pi/180*pt_p)*pr_p,Y-sin(pi/180*pt_p)*pr_p);
                
                var XX,YY;
                    XX=X-(light_x-rad);
                    YY=Y-(light_y-rad);
                if (ds_list_find_index(points_todraw,j)!=-1)
                {
                    draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,__color,1);
                    if (rep__==0)
                        draw_vertex_color(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,__color,1);
                    draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p+cos(pi/180*dir_p)*rad*5,
                                      YY-sin(pi/180*pt_p)*pr_p-sin(pi/180*dir_p)*rad*5,__color,1);
                    
                    draw_vertex_color(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,__color,1);
                    if (rep__==0)
                        draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p+cos(pi/180*dir_p)*rad*5,
                                          YY-sin(pi/180*pt_p)*pr_p-sin(pi/180*dir_p)*rad*5,__color,1);
                    draw_vertex_color(XX+cos(pi/180*pt)*pr+cos(pi/180*dir)*rad*5,
                                      YY-sin(pi/180*pt)*pr-sin(pi/180*dir)*rad*5,__color,1);
                }
                
                /*Draw in the shadow caps if we need to. It draws them in
                  a fan pattern, meaning convex isn't a problem, but concave is.*/
                if (__ls_shadowcaps&&j>1&&rep__==0)
                {
                    draw_vertex_color(XX+cos(pi/180*pt_f)*pr_f,YY-sin(pi/180*pt_f)*pr_f,c_black,1);
                    draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,c_black,1);
                    draw_vertex_color(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,c_black,1);
                }
        }
        
        draw_primitive_end();
        ++rep__;
    }
    ds_list_destroy(points_todraw);
        
}
draw_set_color(c_white);
surface_reset_target();
    

#define ls_light_surface_draw_soft
/*
    Arguments:
    0 -> id
    1 -> update
*/
var worthless=argument1;
draw_set_alpha(1);
draw_set_color(c_white);
var lt_core=5;/*Core size of the light.*/
var surf=ds_list_find_value(argument0,ds_list_size(argument0)-1),
    rad=ds_list_find_value(argument0,2),/*Radius of light*/
    dir=ds_list_find_value(argument0,4),/*Direction*/
    sprd=ds_list_find_value(argument0,3),/*Spread of the light*/
    prec=ds_list_find_value(argument0,6);/*Precision*/
    
/*If the surface was destroyed, recreate it.*/
if (!surface_exists(surf))
{
    surf=surface_create(rad*2,rad*2)
    ds_list_replace(argument0,ds_list_size(argument0)-1,surf);
}
/*We first draw the light itself:*/
draw_set_blend_mode(bm_normal);
surface_set_target(surf);
draw_clear(c_black);
draw_primitive_begin_texture(pr_trianglelist,sprite_get_texture(__ls_penumbra_s,0));
var soft_edge=false;
if (sprd<360)
    soft_edge=true;
    
    draw_vertex_texture_color(rad,rad,0,1,c_white,1);
    draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2))*rad,rad-sin(pi/180*(dir-sprd/2))*rad,soft_edge,0,c_black,1);
    draw_vertex_texture_color(rad+cos(pi/180*(dir-sprd/2+sprd/prec))*rad,rad-sin(pi/180*(dir-sprd/2+sprd/prec))*rad,0,0,c_black,1);
for (var i=dir-sprd/2+sprd/prec;i<=dir+sprd/2-sprd/prec;i+=sprd/prec)
{
    draw_vertex_texture_color(rad,rad,0,1,c_white,1);
    draw_vertex_texture_color(rad+cos(pi/180*i)*rad,rad-sin(pi/180*i)*rad,0,0,c_black,1);
    draw_vertex_texture_color(rad+cos(pi/180*(i+sprd/prec))*rad,rad-sin(pi/180*(i+sprd/prec))*rad,0,0,c_black,1);
}
draw_vertex_texture_color(rad,rad,0,1,c_white,1);
draw_vertex_texture_color(rad+cos(pi/180*(dir+sprd/2-sprd/prec))*rad,rad-sin(pi/180*(dir+sprd/2-sprd/prec))*rad,0,0,c_black,1);
draw_vertex_texture_color(rad+cos(pi/180*(dir+sprd/2))*rad,rad-sin(pi/180*(dir+sprd/2))*rad,soft_edge,0,c_black,1);
draw_primitive_end();
/*Now we need to draw the stencil shadows:*/
var size=ds_list_size(__ls_list_shadow_positions),/*The number of shadows we need to consider*/
    light_x=ds_list_find_value(argument0,0),
    light_y=ds_list_find_value(argument0,1),
    _shads=ds_list_find_value(argument0,8);/*Whether or not there are shadows enabled.*/
for (var i=0;i<size;++i)
{
    /*Culllin on contains the ID of the position. If negative, that
      means that there is culling.*/
    var IDo=ds_list_find_value(__ls_list_shadow_positions,i);
    var ID=abs(ds_list_find_value(abs(IDo),0)),
        X=ds_list_find_value(abs(IDo),1),
        Y=ds_list_find_value(abs(IDo),2);
    var points=ds_grid_height(ID)-1;
    draw_primitive_begin(pr_trianglelist);
    
    /*These will tell from where to where to draw the shadows.*/
    var lmost_point=0,
        rmost_point=points-1,
        direc=1;
    
    /*If it isn't found, then it is a negative ID. This means
      we flip the culling direction*/
    if (ds_list_find_index(__ls_list_shadow_shapes,ID+1)==-1)
        direc=-1;
       
    var points_todraw=ds_list_create();
    /*There will ALWAYS be culling with soft shadows.*/
        var last_px,last_py,direc_tot=0;
           
        /*We grab the first point in the list and start the loop at the next.*/ 
        last_px=X+cos(pi/180*ds_grid_get(ID,0,0))*ds_grid_get(ID,1,0);
        last_py=Y-sin(pi/180*ds_grid_get(ID,0,0))*ds_grid_get(ID,1,0);
        
        var skipfirst=true;
        for (var j=1;j!=1||skipfirst;j=(j+1)%points)
        {
            skipfirst=false;
            var pt,pr,px,py,ff;
            
                pt=ds_grid_get(ID,0,j);
                pr=ds_grid_get(ID,1,j);
                px=X+cos(pi/180*pt)*pr;
                py=Y-sin(pi/180*pt)*pr;
                /*front facing: if ff>0 then we should draw the face.
                  We grab a normal of the lines, then do a dot product 
                  towards the light. Which normal depends on whether
                  clockwise or counter*/
            if (direc==-1)
                ff=sign(dot_product(-(py-last_py),px-last_px,px-light_x,py-light_y));
            else
                ff=sign(dot_product(py-last_py,-(px-last_px),px-light_x,py-light_y));
           
            if (ff==1)
                ds_list_add(points_todraw,j);
            last_px=px;
            last_py=py;
        }
    
    var pt_f=ds_grid_get(ID,0,0),
        pr_f=ds_grid_get(ID,1,0);
    var toggled=true;
    var looping=true;
    var j=0;
    var drawnedge=-1;
    var edges=0;
    draw_primitive_begin(pr_trianglelist);
    while (looping)
    {
        if (drawnedge==-1)
        {
            if (ds_list_find_index(points_todraw,points-1)!=-1)
                drawnedge=true;
            else
                drawnedge=false;
        }
        
        var jx=j-1;
        if (jx<0)
            jx+=points;
            
        var pt=ds_grid_get(ID,0,j),
            pr=ds_grid_get(ID,1,j),
            pt_p=ds_grid_get(ID,0,jx),
            pr_p=ds_grid_get(ID,1,jx);
        var dir=point_direction(light_x,light_y,X+cos(pi/180*pt)*pr,Y-sin(pi/180*pt)*pr),
            dir_p=point_direction(light_x,light_y,X+cos(pi/180*pt_p)*pr_p,Y-sin(pi/180*pt_p)*pr_p);
            
        var XX,YY;
        XX=X-(light_x-rad);
        YY=Y-(light_y-rad);
            
            /*If this edge is accepted in the culled list*/
            if (ds_list_find_index(points_todraw,j)!=-1)
            {
                /*When clockwise, we want pt/r_p, else is right, if is left.
                  When counter, we want pt/r, else is left, if is right
                  We are at an edge!*/
                if (drawnedge==false)
                {
                    draw_set_color(c_red);
                    draw_line_width(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,3);
                    
                    if (direc==1)/*clockwise?*/
                    {
                        var dr_r,dr_l;
                            dr_r=point_direction(light_x+cos(pi/180*(dir-90))*5,light_y-sin(pi/180*(dir-90)*5),
                                                 X+cos(pi/180*pt_p)*pr_p,Y-sin(pi/180*pt_p)*pr_p);
                            dr_l=point_direction(light_x+cos(pi/180*(dir-90))*-5,light_y-sin(pi/180*(dir-90)*-5),
                                                 X+cos(pi/180*pt_p)*pr_p,Y-sin(pi/180*pt_p)*pr_p);
                        draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,c_black,1);
                        draw_vertex_color(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,c_black,1);
                        draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p+cos(pi/180*dr_l)*rad,
                                          YY-sin(pi/180*pt_p)*pr_p-sin(pi/180*dr_l)*rad
                                          ,c_black,1);
                    }
                    
                    
                    ++edges;
                }
                    
                drawnedge=true;
            }
            else
            {
                /*We are at an edge!*/
                if (drawnedge==true)
                {
                    draw_set_color(c_green);
                    draw_line_width(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,3);
                    ++edges;
                }
            
                drawnedge=false;
            }
            
            /*Draw in the shadow caps if we need to. It draws them in
              a fan pattern, meaning convex isn't a problem, but concave is.*/
            if (__ls_shadowcaps&&j>1)
            {
                draw_vertex_color(XX+cos(pi/180*pt_f)*pr_f,YY-sin(pi/180*pt_f)*pr_f,c_black,1);
                draw_vertex_color(XX+cos(pi/180*pt_p)*pr_p,YY-sin(pi/180*pt_p)*pr_p,c_black,1);
                draw_vertex_color(XX+cos(pi/180*pt)*pr,YY-sin(pi/180*pt)*pr,c_black,1);
            }
            
        j=(j+1)%points;
        if (j==0) 
            looping=false;
    }
    ds_list_destroy(points_todraw);
    draw_primitive_end();
        
}
draw_set_color(c_white);
surface_reset_target();
    

#define ls_shadow_create
/*
    argument0=ls_ss_clock,ls_ss_counterclock
    returns the id of the shadow.
*/
var ID=ds_grid_create(2,1);
ds_grid_clear(ID,-1);
ds_list_add(__ls_list_shadow_shapes,(ID+1)*argument0);
return ID;

#define ls_shadow_destroy
/*
    Argument0 -> ID
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0+1);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0-1);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to destroy non-existing shadow: "+string(argument0),1);
    exit;
}
ds_grid_destroy(abs(ds_list_find_value(__ls_list_shadow_shapes,val))-1);
ds_list_delete(__ls_list_shadow_shapes,val);

#define ls_shadow_addpoint_polar
/*
    Arguments:
    0- shadow ID
    1- angle
    2- radius
    3- subdivide
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0+1);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0-1);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to add point to non-existing shadow: "+string(argument0),1);
    return -1;
}
var mygrid=argument0;
var height=ds_grid_height(mygrid);
var array;
    array[1]=height;//Holds the position of this point.
    array[0]=1;//Holds the number points in the array.
/*If not the first point, and recursive split is on, we split things.*/
/*If not the first point, and recursive split is on, we split things.*/
if (argument3>0&&height>1)
{
    var rt,rd,X,Y;
    rt=ds_grid_get(mygrid,0,height-2);
    rd=ds_grid_get(mygrid,1,height-2);
    X=cos(pi/180*argument1)*argument2;
    Y=-sin(pi/180*argument1)*argument2;
    var dis,dir;
    dis=point_distance(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,X,Y);
    dir=point_direction(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,X,Y);
    while (dis>argument3)
    {
        var tmpArray,_length;
        tmpArray=ls_shadow_addpoint_cartesian(argument0,cos(pi/180*rt)*rd+cos(pi/180*dir)*dis/2,-sin(pi/180*rt)*rd-sin(pi/180*dir)*dis,argument3);
    
        _length=tmpArray[0];
        
        //We expand our current array.
        for (var i=_length-1;i>=0;--i)
            array[array[0]+i]=tmpArray[i+1];
        array[0]=array_length_1d(array);
        
        mygrid=argument0;
        height=ds_grid_height(mygrid);
        array[array[0]]=height;
        rt=ds_grid_get(mygrid,0,height-2);
        rd=ds_grid_get(mygrid,1,height-2);
        X=cos(pi/180*argument1)*argument2;
        Y=-sin(pi/180*argument1)*argument2;
        dis=point_distance(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,X,Y);
        dir=point_direction(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,X,Y);
    }
}
    
ds_grid_set(mygrid,0,height-1,argument1);
ds_grid_set(mygrid,1,height-1,argument2);
ds_grid_resize(mygrid,2,height+1);
return array;

#define ls_shadow_addpoint_cartesian
    /*
    Arguments:
    0- shadow ID
    1- x
    2- y
    3- recursive split
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0+1);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0-1);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to add point to non-existing shadow: "+string(argument0),1);
    return -1;
}
var mygrid=argument0;
var height=ds_grid_height(mygrid);
var array;
    array[1]=height;//Holds the position of this point.
    array[0]=1;//Holds the number points in the array.
/*If not the first point, and recursive split is on, we split things.*/
if (argument3>0&&height>1)
{
    var rt,rd;
    rt=ds_grid_get(mygrid,0,height-2);
    rd=ds_grid_get(mygrid,1,height-2);
    var dis,dir;
    dis=point_distance(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,argument1,argument2);
    dir=point_direction(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,argument1,argument2);
    while (dis>argument3)
    {
        var tmpArray,_length;
        tmpArray=ls_shadow_addpoint_cartesian(argument0,cos(pi/180*rt)*rd+cos(pi/180*dir)*dis/2,
                                              -sin(pi/180*rt)*rd-sin(pi/180*dir)*dis/2,argument3);
        
        _length=tmpArray[0];
        
        //We expand our current array.
        for (var i=_length-1;i>=0;--i)
            array[array[0]+i]=tmpArray[i+1];
        array[0]=array_length_1d(array);
        
        mygrid=argument0;
        height=ds_grid_height(mygrid);
        array[array[0]]=height;
        
        rt=ds_grid_get(mygrid,0,height-2);
        rd=ds_grid_get(mygrid,1,height-2);
        dis=point_distance(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,argument1,argument2);
        dir=point_direction(cos(pi/180*rt)*rd,-sin(pi/180*rt)*rd,argument1,argument2);
    }
}
ds_grid_set(mygrid,0,height-1,point_direction(0,0,argument1,argument2));
ds_grid_set(mygrid,1,height-1,point_distance(0,0,argument1,argument2));
ds_grid_resize(mygrid,2,height+1);
return array;

#define ls_shadow_setpoint_polar
/*
    Arguments:
    0- shadow ID
    1- point ID
    2- angle
    3- radius
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0+1);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0-1);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to set point for non-existing shadow: "+string(argument0),1);
    exit;
}
var mygrid=argument0;
    
ds_grid_set(mygrid,0,argument1-1,argument2);
ds_grid_set(mygrid,1,argument1-1,argument3);

#define ls_shadow_setpoint_cartesian
/*
    Arguments:
    0- shadow ID
    1- point ID
    2- x
    3- y
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0+1);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0-1);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to set point for non-existing shadow: "+string(argument0),1);
    exit;
}
var mygrid=argument0;
    
ds_grid_set(mygrid,0,argument1-1,point_direction(0,0,argument2,argument3));
ds_grid_set(mygrid,1,argument1-1,point_distance(0,0,argument2,argument3));

#define ls_shadow_attach_pos
/*
    Arguments:
    0- ID
    1- x
    2- y
    3- culling
    
    Returns ID of this shape.
*/
var ID=ds_list_create();
ds_list_add(ID,argument0);
ds_list_add(ID,argument1);
ds_list_add(ID,argument2);
if (argument3>0)
    ds_list_add(__ls_list_shadow_positions,-ID);
else
    ds_list_add(__ls_list_shadow_positions,ID);
return ID;

#define ls_shadow_detach_pos
/*
    Arguments:
    0- ID
*/
var val=ds_list_find_index(__ls_list_shadow_positions,argument0);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_positions,-argument0);/*For culling.*/
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to destroy non-existing shadow position: "+string(argument0),1);
    return false;
}
ds_list_destroy(argument0);
ds_list_delete(__ls_list_shadow_positions,val);
return true;

#define ls_shadow_modify_pos
/*
    Arguments:
    0- ID
    1- x
    2- y
*/
var val=ds_list_find_index(__ls_list_shadow_positions,argument0);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_positions,-argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to modify non-existing shadow position: "+string(argument0),1);
    return false;
}
ds_list_replace(argument0,1,argument1);
ds_list_replace(argument0,2,argument2);
return true;

#define ls_shadow_clearpoints
/*
    Arguments:
    0- Shadow ID
*/
var val=ds_list_find_index(__ls_list_shadow_shapes,argument0);
if (val==-1)
    val=ds_list_find_index(__ls_list_shadow_shapes,-argument0);
if (val==-1)
{
    show_error(@"Lighting Studio Error:
---
Trying to clear points of non-existing shadow: "+string(argument0),1);
    return false;
}
ds_grid_resize(argument0,2,1);
ds_grid_clear(argument0,-1);
return true;

#define ls_custom_add
/*
    Arguments:
    0 - sprite
    1 - subimg
    2 - x
    3 - y
    4 - rot
    5 - color
*/
if (!sprite_exists(argument0))
{
    show_error(@"Lighting Studio Error:
---
Sprite with index of "+string(argument0)+" does not exist!",false);
return false;
}
var addpos=-1;
for (var i=0;i<ds_grid_height(__ls_shapecustom);++i)
{
    if (ds_grid_get(__ls_shapecustom,0,i)==-1)
    {
        addpos=i;
        break;
    }
}
//If the grid needs to be expanded, we do so:
if (addpos==-1)
{
    addpos=ds_grid_height(__ls_shapecustom);
    ds_grid_resize(__ls_shapecustom,ds_grid_width(__ls_shapecustom),ds_grid_height(__ls_shapecustom)+5);
    for (var i=addpos;i<ds_grid_height(__ls_shapecustom);++i)
    {
        ds_grid_set(__ls_shapecustom,0,addpos+i,-1);
    }
}
ds_grid_set(__ls_shapecustom,0,addpos,argument0);
ds_grid_set(__ls_shapecustom,1,addpos,argument1);
ds_grid_set(__ls_shapecustom,2,addpos,argument2);
ds_grid_set(__ls_shapecustom,3,addpos,argument3);
ds_grid_set(__ls_shapecustom,4,addpos,argument4);
ds_grid_set(__ls_shapecustom,5,addpos,argument5);
return addpos;

#define ls_custom_destroy
/*
    Arguments:
    0- ID
    
    Returns whether sucessful.
*/
var ERROR;
ERROR=false;
if (argument0>=ds_grid_height(__ls_shapecustom))
    ERROR=true;
else
{
    if (ds_grid_get(__ls_shapecustom,0,argument0)==-1)
        ERROR=true;
}
if (ERROR)
{
    show_error(@"Lighting Studio Error:
---
Trying to destroy non-existing custom object: "+string(argument0),0);
    
    return false;
}
ds_grid_set(__ls_shapecustom,0,argument0,-1);
return true;

#define __ls_system_update
/*
    Takes care of drawing things to the surfaces themselves.
*/
if (!__ls_isenabled||ds_list_empty(__ls_attached_views)) exit;
draw_set_alpha(1);
draw_set_color(c_white);
var size=ds_list_size(__ls_list_light_properties);
for (var i=0;i<size;++i)
{
    /*If static, we don't bother updating.*/
    var ID=ds_list_find_value(__ls_list_light_properties,i);
    /*If not visible, we just skip updating*/
    if (ds_list_find_value(ID,ds_list_size(ID)-2)==true)
        //ls_light_surface_draw_soft(ID,0);
        ls_light_surface_draw(ID,0);
        
}
draw_set_blend_mode(bm_normal);
var surfaces=ds_list_size(__ls_attached_views);
for (var i=0;i<surfaces;++i)
{
    var ID=ds_list_find_value(__ls_attached_views,i);
    var xoff=0,yoff=0;
    if (ID!=-1)
    {
        xoff=-__view_get( e__VW.XView, ID );
        yoff=-__view_get( e__VW.YView, ID );
    }
    
    var surf=ds_list_find_value(__ls_surface_finals,i);
    if (!surface_exists(surf))
        ls_view_recalculate();
        
    /*The following snippit fixes things if switching resolutions.
      For some reason, GM may RESIZE the surface instead of destroy it.*/
    if (ID>=0)
    {
        if (surface_get_width(surf)!=__view_get( e__VW.WView, ID )||surface_get_height(surf)!=__view_get( e__VW.HView, ID ))
            ls_view_recalculate();
    }
    else
    {
        if (surface_get_width(surf)!=room_width||surface_get_height(surf)!=room_height)
            ls_view_recalculate();
    }
    
    surface_set_target(surf);
    draw_clear(__ls_ambient);
    
    if (__ls_draw_mode<2)
        draw_set_blend_mode_ext(bm_one,bm_inv_src_color);
    else 
        draw_set_blend_mode(bm_add);
    
    
    /*Draw each light's surface:*/
    for (var i=0;i<size;++i)
    {
        var ID=ds_list_find_value(__ls_list_light_properties,i);
        var rad=ds_list_find_value(ID,2);
        if (!surface_exists(ds_list_find_value(ID,ds_list_size(ID)-1)))
            ls_light_manual_update(ID);
            
        if (ds_list_find_value(ID,ds_list_size(ID)-2)==true)
            draw_surface_ext(ds_list_find_value(ID,ds_list_size(ID)-1),ds_list_find_value(ID,0)-rad+xoff,ds_list_find_value(ID,1)-rad+yoff,1,1,0,ds_list_find_value(ID,5),1);
    }
    
    /*Draw custom shapes:*/
    size=ds_grid_height(__ls_shapecustom);
    for (var i=0;i<size;++i)
    {
        var _sprite;
        _sprite=ds_grid_get(__ls_shapecustom,0,i);
        if (_sprite==-1||!sprite_exists(_sprite)) continue;
        
        draw_sprite_ext(_sprite,
                        ds_grid_get(__ls_shapecustom,1,i),
                        ds_grid_get(__ls_shapecustom,2,i)+xoff,
                        ds_grid_get(__ls_shapecustom,3,i)+yoff,1,1,
                        ds_grid_get(__ls_shapecustom,4,i),
                        ds_grid_get(__ls_shapecustom,5,i),1);
    }
    
    /*Consider drawing shadow caps HERE instead, as it should be faster.
      Also consider turning the caps into sprites and just drawing those.*/
}
surface_reset_target();
draw_set_blend_mode(bm_normal);

#define __ls_linesintersect
/*  x1,y1,x2,y2
    x3,y3,x4,y4*/
var aX=argument0,
    aY=argument1,
    bX=argument2,
    bY=argument3,
    cX=argument4,
    cY=argument5,
    dX=argument6,
    dY=argument7;
var denominator = ((bX - aX) * (dY - cY)) - ((bY - aY) * (dX - cX));
var numerator1 = ((aY - cY) * (dX - cX)) - ((aX - cX) * (dY - cY));
var numerator2 = ((aY - cY) * (bX - aX)) - ((aX - cX) * (bY - aY));
if (denominator == 0) 
    return numerator1 == 0 && numerator2 == 0;
var r = numerator1 / denominator;
var s = numerator2 / denominator;
 
return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);

