extends RichTextLabel

func _process(delta):
	if Input.is_action_pressed("ui_menu"):
		print_debug("ah fuck me");
		get_tree().change_scene(Globalvars.mainMenuScene);
	if Input.is_action_just_pressed("ui_accept"):
		text = "UI accept";
	elif Input.is_action_just_pressed("ui_cancel"):
		text = "UI cancel"
