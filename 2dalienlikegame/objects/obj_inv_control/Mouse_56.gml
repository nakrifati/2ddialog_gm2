// Drop Item
if (global.item != -1)
{
    if (instance_position(mouse_x,mouse_y, obj_inventory_box) && global.game_state = "pause")
    {
    var box = instance_position(mouse_x, mouse_y, obj_inventory_box);
    
    // make sure the slot is empty
    
        if (box.item == -1 && (box.type == scr_get_item_value(global.item,"type") || box.type=""))
        {
        // Put the item in the box
        box.item = global.item;
        global.item = -1;
        }
        else
        {
        // Drop item
        instance_create(mouse_x,mouse_y, global.item)
        global.item = -1;
        }
    }
    else
    {
    instance_create(mouse_x,mouse_y, global.item)
    global.item = -1;
    }
    
}

