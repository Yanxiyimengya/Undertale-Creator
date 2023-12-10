extends LuaGameObject2D;
class_name LuaCollisionObject2D;

func _init() :
	node_type = Node2D; # 定义节点类型

func index(ref : LuaAPI, index) :
	var result = super.index(ref , index);
	if (result != null) :
		return result;
	match (index) :
		_:
			pass;

func newindex(ref : LuaAPI, index, value) :
	var result = super.newindex(ref , index, value);
	if (result != null) :
		return result;
	match (index) :
		_:
			pass;
	pass;
