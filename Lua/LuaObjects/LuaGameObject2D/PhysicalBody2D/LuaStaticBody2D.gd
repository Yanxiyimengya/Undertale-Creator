extends LuaCollisionObject2D;
class_name LuaStaticBody2D;

var physics_material:PhysicsMaterial = null;
var collision_shape_nodes:Array[Node2D] = [];

func _init() :
	node_type = StaticBody2D;
