extends Node2D

var mainMenuScene = "res://scenes/mainmenu.tscn";

# reference to player node
var player;

# references to the level container
var levelcontainer;

# references to the levels
var levels;

# What stage the player has currently selected
var playerPos : int;


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
	movePlayerToLevel(0);
	


func _process(_delta):
	# Back to main Menu on ui_cancel signal
	if Input.is_action_pressed("ui_cancel"):
		var _loadResult = get_tree().change_scene(mainMenuScene);
		if _loadResult == OK:
			print_debug("Successfully switched level");
		else:
			print_debug("Switching levels failed. Errorcode : " + _loadResult);

	# Call method that deals with player movement
	playermovement();


# Move player to center of level with fixed offset of x64,y64
func movePlayerToLevel(levelNum):
	var newPos : Vector2 = levels[levelNum].get_position();
	var offset := Vector2(64,64) as Vector2;
	newPos += offset;
	player.set_position(newPos);
	playerPos = levelNum;
	pass



# Deals with player movement between levels
func playermovement():
	# User wants to send player to the left
	if Input.is_action_just_pressed("ui_left"):
		print_debug("trying to move player left");
		# Checks if player is already all the way to the left
		if playerPos != 0:
			movePlayerToLevel(playerPos-1);

	if Input.is_action_just_pressed("ui_right"):
		print_debug("right button press detected");
		# Checks if player is already all the way to the right
		if playerPos != (len(levels)-1):
			movePlayerToLevel(playerPos+1);
	pass
