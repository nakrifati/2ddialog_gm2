{
    "id": "1f59c1bc-5a6d-4294-be4b-bac0d441a3ac",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "Easy_Lighting_Studio",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": -1,
    "date": "2019-06-28 12:08:41",
    "description": "Adds functions for a simple yet versatile 2D lighting engine.",
    "extensionName": "",
    "files": [
        {
            "id": "77081690-8a9c-431b-bfbf-636784ebd5b7",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "penumbra_s.png",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "C:\\Users\\reuben\\Desktop\\LightingEngine\\penumbra_s.png",
            "uncompress": false
        },
        {
            "id": "bf2d0e17-b4c4-40c2-85dd-4a22ea1aa2a8",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "fb904d17-13c8-4227-87c4-00f77e1f18f6",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ls_dm_dull",
                    "hidden": false,
                    "value": "0"
                },
                {
                    "id": "84b9c333-b63b-4b5b-ab98-6d836500c48b",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ls_dm_normal",
                    "hidden": false,
                    "value": "1"
                },
                {
                    "id": "863d5dfd-f6dd-4fa4-a932-cd68c5b97d10",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ls_dm_vivid",
                    "hidden": false,
                    "value": "2"
                },
                {
                    "id": "cfccb46c-54d3-40af-9607-c777e3fd0922",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ls_ss_cw",
                    "hidden": false,
                    "value": "1"
                },
                {
                    "id": "70c5fd0a-f5eb-49b9-8a7d-9d473af31d48",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ls_ss_ccw",
                    "hidden": false,
                    "value": "-1"
                }
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "EasyLighting.gml",
            "final": "ls_system_free",
            "functions": [
                {
                    "id": "efb00324-5286-42bd-a393-d022e8870a18",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_system_properties",
                    "help": "ls_system_properties(enabled,CONST mode,ambient,caps)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_system_properties",
                    "returnType": 2
                },
                {
                    "id": "7c723d89-5a96-4d6d-9b38-12f105d87422",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_system_draw",
                    "help": "ls_system_draw(update,debug)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_system_draw",
                    "returnType": 2
                },
                {
                    "id": "5f7c00a8-54cb-4dd7-a102-3248869965a3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_view_attach",
                    "help": "ls_view_attach(view)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_view_attach",
                    "returnType": 2
                },
                {
                    "id": "f7398780-c551-4977-aafe-783a36dea1f4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_view_detach",
                    "help": "ls_view_detach(view)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_view_detach",
                    "returnType": 2
                },
                {
                    "id": "e7809e0d-dee0-4c90-987f-c0acbe06bc34",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ls_view_recalculate",
                    "help": "ls_view_recalculate()",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_view_recalculate",
                    "returnType": 2
                },
                {
                    "id": "fb305051-968c-4387-a30d-e93087f28379",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ls_noview_attach",
                    "help": "ls_noview_attach()",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_noview_attach",
                    "returnType": 2
                },
                {
                    "id": "98fca3fc-e7ac-4480-a6df-e6235fae1c67",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ls_noview_detach",
                    "help": "ls_noview_detach()",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_noview_detach",
                    "returnType": 2
                },
                {
                    "id": "eb6ec345-678b-4202-852d-9bdce065da20",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 10,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_light_create",
                    "help": "ls_light_create(x,y,radius,spread,rot,color,precision,static,shadows,corerad)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_create",
                    "returnType": 2
                },
                {
                    "id": "f1027cf6-f4f7-4ef6-b743-c7949053efa1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_destroy",
                    "help": "ls_light_destroy(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_destroy",
                    "returnType": 2
                },
                {
                    "id": "5653670b-7d8f-4c15-ad16-9acfbdf8ce2c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_pos",
                    "help": "ls_light_set_pos(id,x,y)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_pos",
                    "returnType": 2
                },
                {
                    "id": "b8f52ff7-8e58-4018-9251-29e45aa41268",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_rot",
                    "help": "ls_llight_set_rot(id,rot)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_rot",
                    "returnType": 2
                },
                {
                    "id": "73c5e86b-5887-4d96-a829-e30efb11045d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_static",
                    "help": "ls_light_set_static(id,static)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_static",
                    "returnType": 2
                },
                {
                    "id": "55cc83c5-0e72-4537-8553-f03ceb7d7275",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_spread",
                    "help": "ls_light_set_spread(id,spread)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_spread",
                    "returnType": 2
                },
                {
                    "id": "fff4fc0c-1f74-4310-9bc1-7dd0ca35931f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_color",
                    "help": "ls_light_set_color(id,color)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_color",
                    "returnType": 2
                },
                {
                    "id": "d3cc0110-8a18-40ee-8b9f-06d8fc01a582",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_shadows",
                    "help": "ls_light_set_shadows(id,shadows)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_shadows",
                    "returnType": 2
                },
                {
                    "id": "8b0d9350-336e-47ba-b478-0ec7e261b0a8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_x",
                    "help": "ls_light_get_x(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_x",
                    "returnType": 2
                },
                {
                    "id": "f148fb97-9aef-40c7-908f-d580bd355844",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_y",
                    "help": "ls_light_get_y(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_y",
                    "returnType": 2
                },
                {
                    "id": "b3e211e5-082b-49dd-8558-33e2f36efa44",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_rot",
                    "help": "ls_light_get_rot(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_rot",
                    "returnType": 2
                },
                {
                    "id": "c260ec96-7a40-4f79-9e16-be181f903231",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_static",
                    "help": "ls_light_get_static(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_static",
                    "returnType": 2
                },
                {
                    "id": "c0147797-294f-404d-8546-76520a1b2a8a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_spread",
                    "help": "ls_light_get_spread(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_spread",
                    "returnType": 2
                },
                {
                    "id": "120b78e1-cb07-45cf-a016-33b657ee10fb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_color",
                    "help": "ls_light_get_color(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_color",
                    "returnType": 2
                },
                {
                    "id": "4434db75-557a-4095-8f38-634f95b0d671",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_shadows",
                    "help": "ls_light_get_shadows(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_shadows",
                    "returnType": 2
                },
                {
                    "id": "6cc4309f-7da4-4fff-b4ea-dd451ebec0d5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_manual_update",
                    "help": "ls_light_manual_update(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_manual_update",
                    "returnType": 2
                },
                {
                    "id": "da9af15b-998d-4985-ac52-7047626b7e6a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_shadow_create",
                    "help": "ls_shadow_create(CONST direction)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_create",
                    "returnType": 2
                },
                {
                    "id": "a873bbac-de25-4054-a67b-b185ead3c2dd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_shadow_destroy",
                    "help": "ls_shadow_destroy(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_destroy",
                    "returnType": 2
                },
                {
                    "id": "a95ced80-3578-49b6-bda0-e8e7efe83a70",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_addpoint_polar",
                    "help": "ls_shadow_addpoint_polar(id,angle,radius,subdivide)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_addpoint_polar",
                    "returnType": 2
                },
                {
                    "id": "ceebafca-8177-40d0-932c-b38af8ee1c85",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_addpoint_cartesian",
                    "help": "ls_shadow_addpoint_cartesian(id,x,y,subdivide)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_addpoint_cartesian",
                    "returnType": 2
                },
                {
                    "id": "d5b35031-b7d4-4bd6-acf7-ae0fe5dc5ba3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_setpoint_polar",
                    "help": "ls_shadow_setpoint_polar(id,pos,angle,radius)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_setpoint_polar",
                    "returnType": 2
                },
                {
                    "id": "4c462909-d126-4983-9730-04a11704a478",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_setpoint_cartesianls_shadow_setpoint_cartesian",
                    "help": "ls_shadow_setpoint_cartesian(id,pos,x,y)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_setpoint_cartesian",
                    "returnType": 2
                },
                {
                    "id": "f30d5a1b-d383-4bce-8d21-f426ba541507",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_attach_pos",
                    "help": "ls_shadow_attach_pos(id,x,y,culling)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_attach_pos",
                    "returnType": 2
                },
                {
                    "id": "2253ce0b-2eef-42dc-910f-664ac62bb0c3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_shadow_detach_pos",
                    "help": "ls_shadow_detach_pos(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_detach_pos",
                    "returnType": 2
                },
                {
                    "id": "48b40932-f86e-41db-a91a-af579464af6b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_shadow_modify_pos",
                    "help": "ls_shadow_modify_pos(id,x,y)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_modify_pos",
                    "returnType": 2
                },
                {
                    "id": "c154a9f4-ec20-43f3-b172-bfd2072f5004",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_shadow_clearpoints",
                    "help": "ls_shadow_clearpoints(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_shadow_clearpoints",
                    "returnType": 2
                },
                {
                    "id": "59daf77b-2f11-4242-8423-5b66e2f19531",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "__ls_system_update",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "__ls_system_update",
                    "returnType": 2
                },
                {
                    "id": "38bec65f-a8ad-4fc2-a231-878478981379",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "__ls_linesintersect",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "__ls_linesintersect",
                    "returnType": 2
                },
                {
                    "id": "96e55f11-4595-4f46-aa89-d449b5875947",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "ls_system_init",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_system_init",
                    "returnType": 2
                },
                {
                    "id": "d83973a8-8200-4356-9455-4675c404b9f9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "ls_system_free",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_system_free",
                    "returnType": 2
                },
                {
                    "id": "4fad06fc-4dad-4176-9a36-d79f3984ebae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "ls_angledif",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_angledif",
                    "returnType": 2
                },
                {
                    "id": "88585bf8-33ad-4bd1-8a30-b6f815119390",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "ls_light_surface_draw",
                    "help": "",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_surface_draw",
                    "returnType": 2
                },
                {
                    "id": "16d006df-3fc2-48f4-b0ec-7615e4ef9892",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_radius",
                    "help": "ls_light_set_radius(id,radius)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_radius",
                    "returnType": 2
                },
                {
                    "id": "b1f5688e-c5d1-41aa-a637-f4d595c918f3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_radius",
                    "help": "ls_light_get_radius(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_radius",
                    "returnType": 2
                },
                {
                    "id": "e0b88d05-2372-4e13-a4a2-bd54540b0e44",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_visible",
                    "help": "ls_light_set_visible(id,visible)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_visible",
                    "returnType": 2
                },
                {
                    "id": "38608e0e-8d08-4af5-b3e1-6a8ca233df75",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_visible",
                    "help": "ls_light_get_visible(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_visible",
                    "returnType": 2
                },
                {
                    "id": "8ecd0707-e9b8-4b3f-8ce8-938f21c91fa6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 6,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "ls_custom_add",
                    "help": "ls_custom_add(sprite,subimg,x,y,rot,color)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_custom_add",
                    "returnType": 2
                },
                {
                    "id": "a63bbb41-8370-449b-8775-d8a133f0f156",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_custom_destroy",
                    "help": "ls_custom_destroy(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_custom_destroy",
                    "returnType": 2
                },
                {
                    "id": "37d74b87-336a-4e5c-a0fb-211da5344e6c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "ls_light_set_coreradius",
                    "help": "ls_light_set_coreradius(id,radius)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_set_coreradius",
                    "returnType": 2
                },
                {
                    "id": "8b93abf2-ff56-4124-8a18-76722c2d2126",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ls_light_get_coreradius",
                    "help": "ls_light_get_coreradius(id)",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_light_get_coreradius",
                    "returnType": 2
                },
                {
                    "id": "5b2f246d-b3d9-4a59-97ce-8fc2fdad9819",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ls_system_clear",
                    "help": "ls_system_clear",
                    "hidden": false,
                    "kind": 2,
                    "name": "ls_system_clear",
                    "returnType": 2
                }
            ],
            "init": "ls_system_init",
            "kind": 2,
            "order": [
                
            ],
            "origname": "C:\\Users\\reuben\\Desktop\\LightingEngine\\GMScripts.gml",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "C:\\Users\\Alexei\\AppData\\Local\\gamemaker_studio\\extensions\\Easy Lighting Studio.html",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Free to use, also for commercial games.",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "Pre-Release 4 (UD2)"
}