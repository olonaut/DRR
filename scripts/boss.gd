extends CharacterBody2D

# can you guess what this is for??
@export var health: int
@export var objBaseAngle: float

var objects

var rng = RandomNumberGenerator.new()
@export var objSpawnRef: NodePath
var objSpawnPos
@export var healthBarRef: NodePath

# children
var deathAnim;
var sprite;

func _ready():
	rng.randomize()
	objects = get_parent().get_parent().objects
	print_debug(str(objects))
	objSpawnPos = get_node(objSpawnRef).get_position();
	print_debug(str(objSpawnPos))
	
	deathAnim = get_node("DeathAnim")
	sprite = get_node("Sprite2D")

	# Health Bar Stuff
	get_node(healthBarRef).set_max(health)
	get_node(healthBarRef).set_value(health)

	# start attack on player
	burst(7)
	pass # Replace with function body.

func hit():
	health -= 1
	get_node(healthBarRef).set_value(health)
#	print_debug("health: " + str(health))
	if health == 0:
		death()

func death():
	print_debug("boss is dead now x.x")
	sprite.hide()
	deathAnim.show()
	get_node(healthBarRef).hide()
	deathAnim.playing = true
# emits a burst of objects.
# supply type and ammount, optional angle.
# type is any valid object ID, or -1 for mixed mode.
# center of angle is directly downwards
# NOTE: Supply difference in radian
func burst(ammount:int, angle:float = 0.1):
	print_debug("Bursting~~")
	for i in ammount:
		var obj = objects[0].instantiate()
		var _angle = (objBaseAngle*rng.randf_range(angle, angle*-1))*PI
		var __angle = Vector2(sin(_angle),cos(_angle))
		print_debug(str(__angle))
		var linear_velocity = __angle*500
		obj.set_linear_velocity(linear_velocity)
		obj.set_position(objSpawnPos)
		add_child(obj)
	pass
