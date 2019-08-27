//var dialog_num = argument0;
global.dialog_num=argument0
global.game_state = "run";
global.dialog_state=true
global.dialog_npc=argument1
instance_create(__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),obj_dialog)
instance_create(__view_get( e__VW.XView, 0 )+130,__view_get( e__VW.YView, 0 )+550,obj_dialog_a)
instance_create(__view_get( e__VW.XView, 0 )+130,__view_get( e__VW.YView, 0 )+600,obj_dialog_b)
instance_create(__view_get( e__VW.XView, 0 )+130,__view_get( e__VW.YView, 0 )+650,obj_dialog_c)

global.dialog_stage=1
ini_open(working_directory+"quest.ini");
global.npc_spk=ini_read_string(argument0, "Text1", "Error");
global.text_a=ini_read_string(argument0, "A_t1", "Error");
global.text_b=ini_read_string(argument0, "B_t1", "Error");
global.text_c=ini_read_string(argument0, "C_t1", "Error");

ini_close();

