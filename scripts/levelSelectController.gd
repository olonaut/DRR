extends Node2D

var mainMenuScene = "res://scenes/mainmenu.tscn";


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene(mainMenuScene);

