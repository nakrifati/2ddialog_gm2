if (global.game_state == "pause")
{   
    draw_set_alpha(.25);
    draw_roundrect(__view_get( e__VW.XView, 0 )+xstart-32, __view_get( e__VW.YView, 0 )+ystart-32, __view_get( e__VW.XView, 0 )+xstart+32, __view_get( e__VW.YView, 0 )+ystart+32,false);
    draw_set_alpha(1);
    
    if (item != -1)
        {
        draw_sprite(object_get_sprite(item),0,__view_get( e__VW.XView, 0 )+xstart, __view_get( e__VW.YView, 0 )+ystart);
        }
}
//draw_self();
//draw_text(x,y,type)

