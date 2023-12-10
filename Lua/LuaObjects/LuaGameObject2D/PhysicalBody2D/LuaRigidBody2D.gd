extends LuaCollisionObject2D;
class_name LuaRigidBody2D;

var physics_material:PhysicsMaterial = null:
	set(value) :
		valid_node.physics_material_override = value;
var collision_shape_nodes:Array[Node2D] = [];

func _init() :
	node_type = RigidBody2D;

func index(ref : LuaAPI, index) :
	match (index) :
		"position" :
			return valid_node.position;

func newindex(ref : LuaAPI, index, value) :
	match (index) :
		"position" :
			valid_node.position = value;
			return true;
	return null;
	
