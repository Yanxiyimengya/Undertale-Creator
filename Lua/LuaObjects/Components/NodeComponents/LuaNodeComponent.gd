extends LuaComponent;
class_name LuaNodeComponent;
signal component_node_ready;
# 附加节点的组件的基类

var owner : Node = null: # 节点的父级
	set(value) :
		owner = value;
		if (component_node) :
			value.add_child(component_node);
			component_node.owner = owner;
var component_node : Node = null: # 
	set(value) :
		component_node = value;
		component_node.ready.connect(func() :
			component_node_ready.emit();
			);
var component_node_type : Object = Node;

func _init():
	super._init();
	pass;

func index(ref : LuaAPI, index) :
	pass;
	# Lua Index元方法 (子类重写)

func __index(ref : LuaAPI, index) :
	var result = index(ref, index);
	if (result) :
		return result;
	match (index) :
		_:
			return result;
	# Lua Index元方法

func newindex(ref : LuaAPI, index, value) :
	pass;
	# Lua NewIndex元方法 (子类重写)

func __newindex(ref : LuaAPI, index, value) :
	match (index) :
		_:
			newindex(ref, index, value);
	# Lua NewIndex元方法
