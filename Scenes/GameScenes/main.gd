extends Node2D

var ls:LuaAPI = LuaGlobal.create_state();

# Called when the node enters the scene tree for the first time.
func _ready():
	
	ls.push_variant("Object2D", LuaGlobal.create_gameobject_2d);
	ls.push_variant("RigidBody2D", LuaGlobal.create_gameobject_rigidbody2d);
	ls.push_variant("StaticBody2D", LuaGlobal.create_gameobject_staticbody2d);
	
	ls.push_variant("ShapeCircle", LuaGlobal.create_collision_shape_circle);
	ls.push_variant("ShapeRectangle", LuaGlobal.create_collision_shape_rectangle);
	
	var res = ls.do_string(AssetsManager.scripts["script.lua"]);
	if (res is LuaError) :
		print("Lua ERROR In Build:\n" + str(res.type) + "\n" + res.message)
	res = ls.call_function("Start",[]);
	if (res is LuaError) :
		print("Lua ERROR:\n" + str(res.type) + "\n" + res.message) 
	

func _process(delta):
	ls.call_function("Update",[]);
	pass

