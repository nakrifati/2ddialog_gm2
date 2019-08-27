//Take item
if (item != -1 && global.game_state == "pause" && type != "cloth")
{
    global.item=item;
    item = -1;
}

if (item != -1 && global.game_state == "pause" && type = "cloth")
{
    if (scr_get_item_value(global.item,"type") = "cloth")
    {
    global.item=item;
    item = -1;
    }
}

