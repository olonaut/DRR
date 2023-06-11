extends RigidBody2D

var explisionEffect : Node2D;
var sprite : Sprite2D;
var time = 0.0;

@export var movementType : int;

func _ready():
	explisionEffect = get_child(2)
	sprite = get_child(0)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if movementType == 1:
		self.set_angular_velocity(rng.randf_range(-1.0, 1.0))

func _physics_process(delta):
	time += delta
	if movementType == 2:
		self.linear_velocity = Vector2(sin(PI/2 + time*5)*1000.0,self.linear_velocity.y)

func hit():
	movementType = 0;
	self.linear_velocity = Vector2(0,0);
	self.angular_velocity = 0.0;
	explisionEffect.set_emitting(true);
	self.set_collision_layer(0)
	self.set_collision_mask(0)
	sprite.free();
	await get_tree().create_timer(1.25).timeout
	queue_free();

func _on_Whiskey_body_entered(body):
	if body.is_in_group("player"):
		body.hit();
		hit();
