extends RefCounted;
class_name LuaGameObject;

# 游戏物体对Lua部分公开的对象基类

var node_type = Node;
var valid_node : Node = null; # 索引的有效节点
var components = {
} # 游戏物体组件列表 

func add_component(component : Object) :
	components[component] = component.new();
	if (components[component] is LuaNodeComponent) :
		if (components[component].component_node_type) :
			components[component].component_node = components[component].component_node_type.new();
		components[component].owner = valid_node;
	return components[component];

func get_component(component : Object) :
	if (components.has(component)) :
		return components[component];
	return null;
	pass;

func _init(scene_tree : SceneTree = null) :
	valid_node = Node.new(); # 生成节点实例
	if (scene_tree) :
		scene_tree.current_scene.add_child(valid_node);
		# 入树
	# 初始化

func index(ref : LuaAPI, index) :
	pass;
	# Lua Index元方法 (子类重写)

func __index(ref : LuaAPI, index) :
	var result = index(ref, index);
	if (result) :
		return result;
	match (index) :
		"AddComponent" :
			return add_component;
		"GetComponent" :
			return get_component;
		_:
			return result;
	# Lua Index元方法

func newindex(ref : LuaAPI, index, value) :
	pass;
	# Lua NewIndex元方法 (子类重写)

func __newindex(ref : LuaAPI, index, value) :
	var result = newindex(ref, index, value);
	if (result) :
		return result;
	match (index) :
		_:
			return result;
	# Lua NewIndex元方法
