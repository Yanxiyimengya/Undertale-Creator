extends Node;

# 全局Lua方面的单例

var game_file_dir: String = "res://UndertaleTestProject/";

static func create_state() :
	var _l_state = LuaAPI.new(); # 创建 Lua 虚拟机
	_l_state.bind_libraries(["math"])
	_l_state.push_variant("Components", LuaGlobal.gameobject_components);
	_l_state.push_variant("Assets", AssetsManager);
	
	_l_state.push_variant("print", LuaGlobal.lua_print);
	return _l_state;


var gameobject_components = {
	Sprite = LuaComponentSprite,
	
	CollisionShape2D = LuaComponentCollisionShape2D,
};

func lua_print(value) :
	print(value);

func create_gameobject_type(type : GDScript) -> LuaGameObject:
	var gameobject:LuaGameObject = type.new();
	gameobject.valid_node = gameobject.node_type.new();
	get_tree().current_scene.add_child(gameobject.valid_node);
	return gameobject;
	# GDS 方面调用 方便地创建LuaGameObject实例 (实例需合法继承并正确重写_init方法)

func create_gameobject() -> LuaGameObject:
	var _lua_gameobject:LuaGameObject = LuaGameObject.new();
	_lua_gameobject.valid_node = _lua_gameobject.node_type.new();
	get_tree().current_scene.add_child(_lua_gameobject.valid_node);
	return _lua_gameobject;

func create_gameobject_2d() -> LuaGameObject2D :
	var _lua_gameobject:LuaGameObject2D = LuaGameObject2D.new();
	_lua_gameobject.valid_node = _lua_gameobject.node_type.new();
	get_tree().current_scene.add_child(_lua_gameobject.valid_node);
	return _lua_gameobject;

func create_gameobject_rigidbody2d() -> LuaRigidBody2D :
	var _lua_gameobject:LuaRigidBody2D = LuaRigidBody2D.new();
	_lua_gameobject.valid_node = _lua_gameobject.node_type.new();
	get_tree().current_scene.add_child(_lua_gameobject.valid_node);
	return _lua_gameobject;

func create_gameobject_staticbody2d() -> LuaStaticBody2D :
	var _lua_gameobject:LuaStaticBody2D = LuaStaticBody2D.new();
	_lua_gameobject.valid_node = _lua_gameobject.node_type.new();
	get_tree().current_scene.add_child(_lua_gameobject.valid_node);
	return _lua_gameobject;

func create_collision_shape_rectangle(x, y) :
	var shape: LuaCollisionShapeRectangle = LuaCollisionShapeRectangle.new();
	print(shape)
	shape.size = Vector2(x, y);
	return shape;

func create_collision_shape_circle(radius:float = 0.0) :
	var shape: LuaCollisionShapeCircle = LuaCollisionShapeCircle.new();
	shape.radius = radius;
	return shape;
