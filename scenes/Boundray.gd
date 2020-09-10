extends Area2D

func _on_Boundray_body_entered(body):
	print_debug("detroying " + str(body));
	body.queue_free();
