if (global.game_state == "pause" )
{
     draw_sprite_ext(spr_hat,0,__view_get( e__VW.XView, 0 )+xstart,__view_get( e__VW.YView, 0 )+ystart,1,1,0,c_black,.25);
}

event_inherited();

