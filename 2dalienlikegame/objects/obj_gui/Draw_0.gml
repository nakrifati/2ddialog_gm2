// debug
draw_set_font(c_black);

draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+15,string_hash_to_newline("Game State:" + string(global.game_state)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+30, string_hash_to_newline("Cloth on:" + string(obj_gg.cloth)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+45, string_hash_to_newline("Walk Speed:" + string(obj_gg.walk_speed)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+60,string_hash_to_newline("Item Holding"+ string(global.item)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+75,string_hash_to_newline("X:" + string(mouse_x)))
draw_text(__view_get( e__VW.XView, 0 )+80,__view_get( e__VW.YView, 0 )+75,string_hash_to_newline("Y:" + string(mouse_y)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+90,string_hash_to_newline("Dialog Num:"+ string(global.dialog_num)))
draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+105,string_hash_to_newline("Dialog Stage:" + string(global.dialog_stage)))
draw_sprite(spr_debug_window,0,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ))

//
if global.seconds > 10
{
draw_text(__view_get( e__VW.XView, 0 )+165,__view_get( e__VW.YView, 0 )+15,string_hash_to_newline(string(global.minuts) +":"+ string(global.seconds)))
}
else
draw_text(__view_get( e__VW.XView, 0 )+165,__view_get( e__VW.YView, 0 )+15,string_hash_to_newline(string(global.minuts) +":0"+ string(global.seconds)))

draw_text(__view_get( e__VW.XView, 0 )+165,__view_get( e__VW.YView, 0 )+30,string_hash_to_newline("Money:"+ string(global.money)))
draw_healthbar(__view_get( e__VW.XView, 0 )+165,__view_get( e__VW.YView, 0 )+50,__view_get( e__VW.XView, 0 )+230,__view_get( e__VW.YView, 0 )+60,global.hp,c_black,c_maroon,c_teal,0,true,0)



