extends Node2D

# RES-URL for level selection. Substitute $ with level number (1-indexed)
var levelRessource = "res://scenes/levels/level$.tscn"

# Reference to player node
var player;

# References to the level container
var levelcontainer;

# References to the levels
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
		var _loadResult = get_tree().change_scene_to_file(Globalvars.mainMenuScene);
		if _loadResult == OK:
			print_debug("Successfully switched level");
		else:
			print_debug("Switching levels failed. Errorcode : " + _loadResult);

	# Call method that deals with player movement
	playermovement();

	# Check if user selects level
	if Input.is_action_just_pressed("ui_accept"):
		enterLevel();



# Move player to center of level with fixed offset of x64,y64
func movePlayerToLevel(levelNum):
	var newPos : Vector2 = levels[levelNum].get_position();
	var offset := Vector2(64,64) as Vector2;
	newPos += offset;
	player.set_position(newPos);
	playerPos = levelNum;



# Deals with player movement between levels
func playermovement():
	# User wants to send player to the left
	if Input.is_action_just_pressed("ui_left"):
		# Checks if player is already all the way to the left
		if playerPos != 0:
			movePlayerToLevel(playerPos-1);

	if Input.is_action_just_pressed("ui_right"):
		# Checks if player is already all the way to the right
		if playerPos != (len(levels)-1):
			movePlayerToLevel(playerPos+1);



# Enter level.
# Takes player position as level selector.
func enterLevel():
	var _loadResult = get_tree().change_scene_to_file(levelRessource.replace("$",str(playerPos+1)));
	if _loadResult == OK:
		print_debug("Successfully switched level");
	else:
		print_debug("Switching levels failed. Errorcode : " + _loadResult);



# Signal "mouse entered" from collision shapes
func _on_Area2D_mouse_entered(source):
	# Move player to the level of the level node
	# This is supposed to come as an int, but we cast it just to be sure
	movePlayerToLevel(int(source));



func _on_Area2D_input_event(viewport, event, shape_idx, source):
	if event is InputEventMouseButton:
		print_debug("click: " + str(viewport) + " " + str(event) + " " + str(shape_idx));
		print_debug("CLICK at source " + str(source));
		enterLevel();
		# Okay so the problem here is that, it is theoretically possible
		# for the player to not be on the same scene that the mouse is on
		# when the mouse clicks and it ends up loading the wrong level.
		# This could happen when the user clicks on an object and the 
		# signal is triggered before _proccess is called.
		# So it's a race condition between the CPU and an interrupt.
		# This is an edge case and I can't be bothered to fix that right now.
