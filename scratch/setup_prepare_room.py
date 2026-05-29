import os
import json
import shutil
import uuid

def duplicate_room(src, dst, obj_to_add):
    src_dir = f"e:/Programming/Game_/game_final/rooms/{src}"
    dst_dir = f"e:/Programming/Game_/game_final/rooms/{dst}"
    os.makedirs(dst_dir, exist_ok=True)
    
    with open(f"{src_dir}/{src}.yy", "r", encoding="utf-8") as f:
        data = json.load(f)
        
    data["%Name"] = dst
    data["name"] = dst
    
    # replace instance
    if data["layers"] and len(data["layers"]) > 0:
        for layer in data["layers"]:
            if layer["resourceType"] == "GMRInstanceLayer":
                if layer["instances"] and len(layer["instances"]) > 0:
                    inst = layer["instances"][0]
                    inst["name"] = "inst_" + str(uuid.uuid4()).replace("-", "")[:8].upper()
                    inst["objectId"]["name"] = obj_to_add
                    inst["objectId"]["path"] = f"objects/{obj_to_add}/{obj_to_add}.yy"
                    data["instanceCreationOrder"] = [{"name": inst["name"], "path": f"rooms/{dst}/{dst}.yy"}]
                    layer["instances"] = [inst]
                    break
                    
    with open(f"{dst_dir}/{dst}.yy", "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
        
def add_to_yyp(res_type, name):
    yyp_path = "e:/Programming/Game_/game_final/game_final.yyp"
    with open(yyp_path, "r", encoding="utf-8") as f:
        data = json.load(f)
        
    # check if exist
    for res in data["resources"]:
        if res["id"]["name"] == name:
            return
            
    if res_type == "room":
        data["resources"].append({"id": {"name": name, "path": f"rooms/{name}/{name}.yy"}})
        data["RoomOrderNodes"].insert(len(data["RoomOrderNodes"])-1, {"roomId": {"name": name, "path": f"rooms/{name}/{name}.yy"}})
    elif res_type == "object":
        data["resources"].append({"id": {"name": name, "path": f"objects/{name}/{name}.yy"}})
        
    # sort resources by name for cleaner look
    data["resources"].sort(key=lambda x: x["id"]["name"])
    
    with open(yyp_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)

def create_object(name):
    dst_dir = f"e:/Programming/Game_/game_final/objects/{name}"
    os.makedirs(dst_dir, exist_ok=True)
    obj_data = {
      "$GMObject": "",
      "%Name": name,
      "eventList": [],
      "managed": True,
      "name": name,
      "overriddenProperties": [],
      "parent": {
        "name": "game_final",
        "path": "game_final.yyp"
      },
      "parentObjectId": None,
      "persistent": False,
      "physicsAngularDamping": 0.1,
      "physicsDensity": 0.5,
      "physicsFriction": 0.2,
      "physicsGroup": 1,
      "physicsKinematic": False,
      "physicsLinearDamping": 0.1,
      "physicsObject": False,
      "physicsRestitution": 0.1,
      "physicsSensor": False,
      "physicsShape": 1,
      "physicsShapePoints": [],
      "physicsStartAwake": True,
      "properties": [],
      "resourceType": "GMObject",
      "resourceVersion": "2.0",
      "solid": False,
      "spriteId": None,
      "spriteMaskId": None,
      "visible": True
    }
    with open(f"{dst_dir}/{name}.yy", "w", encoding="utf-8") as f:
        json.dump(obj_data, f, indent=2)

create_object("obj_item_selector")
create_object("obj_theme_board")
add_to_yyp("object", "obj_item_selector")
add_to_yyp("object", "obj_theme_board")

duplicate_room("room_start", "rm_prepare_canvas", "obj_item_selector")
add_to_yyp("room", "rm_prepare_canvas")
