extends PopupMenu

func _process(delta):
	# i have no idea why this needs to be false, but it doesnt work if its true
	# someone please explain it to me i am desperate
	if self.visible == false:
		if Input.is_action_just_released("ui_cancel"):
			print_debug("unpause");
			self.hide()
			get_tree().paused = not get_tree().paused
