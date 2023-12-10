extends LuaGameObject;
class_name LuaGameObject2D;

func _init():
	node_type = Node2D;

func index(ref : LuaAPI, index) :
	match (index) :
		"position" :
			return valid_node.position;
		"rotation" :
			return valid_node.rotation_degrees;
		"scale" :
			return valid_node.scale;

func newindex(ref : LuaAPI, index, value) :
	match (index) :
		"position" :
			valid_node.position = value;
			return true;
		"rotation" :
			valid_node.rotation_degrees = value;
			return true;
		"scale" :
			valid_node.scale = value;
			return true;
	return null;
	
