
function Start()

    --Components.CollisionShape2D = 1234555;

    myObject = Object2D();
    myObject.AddComponent(Components.Sprite).texture = Assets.LoadImage('qwe.png');
    myObject.AddComponent(Components.CollisionShape2D).AddShape(ShapeCircle(80));
    
    myObject2 = StaticBody2D();
    myObject2.rotation = 20;
    myObject2.position = Vector2(320, 420);
    myObject2.AddComponent(Components.CollisionShape2D).AddShape(ShapeRectangle(100,50));
    --myObject2.GetComponent(Components.CollisionShape2D).RemoveShape(0);

    print(myObject2.GetComponent(Components.CollisionShape2D).GetShapeList());
end

timer = 1;
function Update()
    myObject.position = Vector2(320,230 + math.sin(timer * 0.1) * 30);
    timer = timer + 1;
end
