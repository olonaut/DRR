extends Area2D

func _on_Boundray_body_entered(body):
	body.free();
