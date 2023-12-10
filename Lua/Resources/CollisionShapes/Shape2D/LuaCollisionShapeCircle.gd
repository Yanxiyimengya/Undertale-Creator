extends LuaCollisionShape2D;
class_name LuaCollisionShapeCircle;

# 一个矩形的2D碰撞形状

var radius:float = 0.0:
	set(value):
		res_shape.radius = value;
		radius = res_shape.radius;

func _init():
	res_shape = CircleShape2D.new();
	pass;

func index(ref : LuaAPI, index) :
	match (index) :
		"radius" :
			return radius;
	# Lua Index元方法 (子类重写)

func newindex(ref : LuaAPI, index, value) :
	match (index) :
		"radius" :
			radius = value;
	# Lua NewIndex元方法 (子类重写)
