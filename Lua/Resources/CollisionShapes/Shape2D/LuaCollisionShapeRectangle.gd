extends LuaCollisionShape2D;
class_name LuaCollisionShapeRectangle;

# 一个矩形的2D碰撞形状

var size:Vector2 = Vector2.ZERO:
	set(value):
		res_shape.size = value;
		size = res_shape.size;

func _init():
	res_shape = RectangleShape2D.new();
	pass;

func index(ref : LuaAPI, index) :
	match (index) :
		"size" :
			return size;
	pass;

func newindex(ref : LuaAPI, index, value) :
	match (index) :
		"size" :
			size = value;
	pass;
	# Lua NewIndex元方法 (子类重写)
