var item = object_get_name(argument0);
var prop = argument1;

var item_obj = ds_map_find_value(global.items, item);
return ds_map_find_value(item_obj, prop);
