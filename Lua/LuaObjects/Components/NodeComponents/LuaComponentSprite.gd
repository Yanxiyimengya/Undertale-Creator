extends LuaNodeComponent;
class_name LuaComponentSprite;

# Sprite 组件

func init() :
	component_node_type = Sprite2D;

func index(ref : LuaAPI, index) :
	match (index) :
		"texture" :
			return component_node.texture;
	pass;

func newindex(ref : LuaAPI, index, value) :
	match (index) :
		"texture" :
			if (value is Texture) :
				component_node.texture = value;
