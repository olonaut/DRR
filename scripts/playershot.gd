extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _init(delta):
	#move_child(self.get_child(0),1);
	add_force(Vector2(0,0),Vector2(0,-150))
	
