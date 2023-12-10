extends RefCounted;
class_name LuaCollisionShape;

# 碰撞体形状 基类

var res_shape: Resource = null:
	set(value) :
		if (value is Shape2D || value is Shape3D) :
			res_shape = value;
# 碰撞实例

func init() :
	pass;

func _init():
	init();

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
	var result = newindex(ref, index, value);
	if (result) :
		return result;
	match (index) :
		_:
			return result;
	# Lua NewIndex元方法
