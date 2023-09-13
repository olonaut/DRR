extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		var result = get_tree().change_scene_to_file(Globalvars.mainMenuScene);
		if result != 0:
			print_debug("Level load failed with errorcode: " + result);


# Open link
func _on_credit_link_clicked(meta):
	print_debug("clicked link:", meta) # you can remove this line
	
	if OS.shell_open(meta) != OK:
		print_debug("Failed to open link!")
