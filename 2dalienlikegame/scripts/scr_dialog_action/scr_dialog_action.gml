ini_open(working_directory+"quest.ini");

action=ini_read_string(argument0, string(argument1)+string(argument2), "Error")

global.dialog_stage=action

switch(action)
 {
        case "EndConv":
        global.dialog_state=false
        obj_dialog.alarm[0]=1
        obj_dialog_a.alarm[0]=1
        obj_dialog_b.alarm[0]=1
        obj_dialog_c.alarm[0]=1
        global.npc_spk=""
        global.text_a=""
        global.text_b=""
        global.text_c=""
        global.dialog_npc=""
        //global.dialog_stage=0
        global.dialog_num=""
        global.game_state = "pause";
        break;
        
        case "EndConv_1":
        global.dialog_state=false
        obj_dialog.alarm[0]=1
        obj_dialog_a.alarm[0]=1
        obj_dialog_b.alarm[0]=1
        obj_dialog_c.alarm[0]=1
        global.npc_spk=""
        global.text_a=""
        global.text_b=""
        global.text_c=""
        global.dialog_npc.alarm[0]=1
        global.dialog_npc=""
        //global.dialog_stage=0
        global.dialog_num=""
        global.game_state = "pause";
        break;
        
        default:
        global.npc_spk=ini_read_string(argument0,"Text"+string(action), "Error");
        global.text_a=ini_read_string(argument0, "A_t"+string(action), "Error");
        global.text_b=ini_read_string(argument0, "B_t"+string(action), "Error");
        global.text_c=ini_read_string(argument0, "C_t"+string(action), "Error");
        break;
 }     
 
 ini_close();  
