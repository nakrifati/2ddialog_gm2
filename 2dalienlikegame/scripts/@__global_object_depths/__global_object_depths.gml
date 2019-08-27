// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = 0; // obj_w_blocker
global.__objectDepths[1] = -11; // obj_gg
global.__objectDepths[2] = 0; // obj_door_w
global.__objectDepths[3] = 0; // obj_door_h
global.__objectDepths[4] = -14; // obj_gui
global.__objectDepths[5] = -10; // obj_inventory_box
global.__objectDepths[6] = -20; // obj_inv_control
global.__objectDepths[7] = 0; // obj_items
global.__objectDepths[8] = 0; // obj_item_parent
global.__objectDepths[9] = -10; // obj_hat
global.__objectDepths[10] = -10; // obj_empty
global.__objectDepths[11] = -10; // obj_hat_box
global.__objectDepths[12] = -12; // obj_dialog
global.__objectDepths[13] = -12; // obj_dialog_a
global.__objectDepths[14] = -12; // obj_dialog_b
global.__objectDepths[15] = -12; // obj_dialog_c
global.__objectDepths[16] = 0; // obj_npc_test
global.__objectDepths[17] = 0; // obj_global
global.__objectDepths[18] = 0; // obj_fake_door_h
global.__objectDepths[19] = 0; // obj_fake_door_w
global.__objectDepths[20] = 0; // obj_static_light
global.__objectDepths[21] = 0; // obj_bullet
global.__objectDepths[22] = 0; // obj_enemy_bullet
global.__objectDepths[23] = 0; // obj_enemy_static
global.__objectDepths[24] = 0; // obj_enemy_tank
global.__objectDepths[25] = 0; // obj_smart_tank


global.__objectNames[0] = "obj_w_blocker";
global.__objectNames[1] = "obj_gg";
global.__objectNames[2] = "obj_door_w";
global.__objectNames[3] = "obj_door_h";
global.__objectNames[4] = "obj_gui";
global.__objectNames[5] = "obj_inventory_box";
global.__objectNames[6] = "obj_inv_control";
global.__objectNames[7] = "obj_items";
global.__objectNames[8] = "obj_item_parent";
global.__objectNames[9] = "obj_hat";
global.__objectNames[10] = "obj_empty";
global.__objectNames[11] = "obj_hat_box";
global.__objectNames[12] = "obj_dialog";
global.__objectNames[13] = "obj_dialog_a";
global.__objectNames[14] = "obj_dialog_b";
global.__objectNames[15] = "obj_dialog_c";
global.__objectNames[16] = "obj_npc_test";
global.__objectNames[17] = "obj_global";
global.__objectNames[18] = "obj_fake_door_h";
global.__objectNames[19] = "obj_fake_door_w";
global.__objectNames[20] = "obj_static_light";
global.__objectNames[21] = "obj_bullet";
global.__objectNames[22] = "obj_enemy_bullet";
global.__objectNames[23] = "obj_enemy_static";
global.__objectNames[24] = "obj_enemy_tank";
global.__objectNames[25] = "obj_smart_tank";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	if (objID >= 0) {
		global.__objectID2Depth[ objID ] = global.__objectDepths[i];
	} // end if
} // end for