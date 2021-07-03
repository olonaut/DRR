###
### Shots expect whatever they hit to have a hit() function
###
extends RigidBody2D

# when hitting another object, die.
func _on_RigidBody2D_body_entered(_body):
	_body.hit();
	queue_free();
	pass 
