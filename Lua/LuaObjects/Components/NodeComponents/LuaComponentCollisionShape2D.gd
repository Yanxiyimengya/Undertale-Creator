extends LuaNodeComponent;
class_name LuaComponentCollisionShape2D;

var shapes_list:Array[LuaCollisionShape2D] = [];
var collision_shape_nodes:Array[Node] = [];

func init() :
	component_node_type = null;

func AddShape(shape:LuaCollisionShape2D) :
	if (shape == null) :
		return;
	if (!shapes_list.has(shape)) :
		var shape_node: Node2D;
		shape_node = CollisionShape2D.new();
		shape_node.shape = shape.res_shape;
		owner.add_child(shape_node);
		shapes_list.push_back(shape);
		collision_shape_nodes.push_back(shape_node);
		return shapes_list.size() - 1;
	return null;

func GetShape(ind: int) :
	if (ind < 0 || ind >= shapes_list.size()) :
		return null;
	return shapes_list[ind];

func GetShapeList() :
	return LuaTuple.from_array(shapes_list);

func RemoveShape(ind: int) :
	if (ind < 0 || ind >= shapes_list.size()) :
		return null;
	shapes_list.remove_at(ind);
	collision_shape_nodes[ind].queue_free();
	collision_shape_nodes.remove_at(ind);

func __index(ref : LuaAPI, index) :
	match (index) :
		"AddShape":
			return AddShape;
		"GetShape":
			return GetShape;
		"GetShapeList":
			return GetShapeList;
		"RemoveShape":
			return RemoveShape;
	# Lua Index元方法
