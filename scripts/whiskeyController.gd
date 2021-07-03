extends RigidBody2D

var explisionEffect : Node2D;
var sprite : Sprite;

func _ready():
	explisionEffect = get_child(2)
	sprite = get_child(0)	

func hit():
	linear_velocity = Vector2(0,0);
	angular_velocity = 0.0;
	explisionEffect.emitting = true;
	sprite.free();
	yield(get_tree().create_timer(1.25), "timeout")
	queue_free();
