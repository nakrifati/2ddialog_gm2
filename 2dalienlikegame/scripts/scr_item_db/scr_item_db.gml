// Hat (test)
hat = ds_map_create();
ds_map_add(hat, "sprite", spr_hat);
ds_map_add(hat, "speed_bonus", 10);
ds_map_add(hat, "type", "cloth");
// empty test item
empty_box = ds_map_create();
ds_map_add(empty_box, "sprite", spr_test_obj);
ds_map_add(empty_box, "type", "misc");

//--------------------------------------

// Items DB

global.items = ds_map_create();
ds_map_add(global.items,"obj_hat",hat);
ds_map_add(global.items,"obj_empty",empty_box);
