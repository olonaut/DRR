extends Node2D

var mainMenuScene = "res://scenes/mainmenu.tscn";

# reference to player node
var player;

# references to the level container
var levelcontainer;

# references to the levels
var levels;

# What stage the player has currently selected
var playperPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children();

	# Find level container
	for n in children:
		if n.name == "levelContainer":
			print_debug("Found level Container! " + n.to_string());
			levelcontainer = n;
			break;
			
	# Apply reference to the levels
	levels = levelcontainer.get_children();

	# Found n levels
	print_debug("Found " + str(len(levels)) + " levels.")
	
	# Find player
	for n in children:
		if n.name == "player":
			print_debug("Found player! " + n.to_string());
			player = n;
			break;
	
	# Move player to first level when starting
	movePlayerToLevel(levels[0]);
	
func _process(_delta):
	# Back to main Menu on ui_cancel signal
	if Input.is_action_pressed("ui_cancel"):
		var _loadResult = get_tree().change_scene(mainMenuScene);
		if _loadResult == OK:
			print_debug("Successfully switched level");
		else:
			print_debug("Switching levels failed. Errorcode : " + _loadResult);
	
# Move player to center of level with fixed offset of x64,y64
func movePlayerToLevel(level):
	var newPos : Vector2 = level.get_position();
	var offset := Vector2(64,64) as Vector2;
	newPos += offset;
	player.set_position(newPos);
	pass
