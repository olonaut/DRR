extends RigidBody2D

var explisionEffect : Node2D;
var sprite : Sprite;

func _ready():
	explisionEffect = get_child(2)
	sprite = get_child(0)	

func hit():
	linear_velocity = Vector2(0,0);
	angular_velocity = 0.0;
	explisionEffect.set_emitting(true);
	self.set_collision_layer(0)
	self.set_collision_mask(0)
	sprite.free();
	yield(get_tree().create_timer(1.25), "timeout")
	queue_free();


func _on_Whiskey_body_entered(body):
	if body.is_in_group("player"):
		body.hit();
	pass # Replace with function body.
