extends RichTextLabel


var mainMenuScene = "res://scenes/mainmenu.tscn";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		print_debug("ah fuck me");
		get_tree().change_scene(mainMenuScene);
	if Input.is_action_just_pressed("ui_accept"):
		text = "uwu u pressd me";
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
