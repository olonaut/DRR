extends Node2D

class_name levelControler

var music : Node;
export var bgMusic : AudioStream;
var objSpawn : ReferenceRect

# level variables
# this is mostly stuff for spawning enemies
export var isActive : bool;	# we want the level to stop when the player dies for ex.
export var stage : int; 	# this controls the boss and the type of objects
export var totalWaves : int;	# number of waves
export var objPerWave : int;	# number of objects per wave
export var waveDelay : int; 	# how long to wait between waves

func _ready():
	# get object spawn area
	objSpawn = get_node("ObjSpawn")
	
	print_debug(bgMusic)

	# play music
	music = get_tree().root.get_node("BgMusic");
	music.stop(); # this is technically not necessary but.. you know. just in case.
	music.stream = bgMusic;
	music.play();

func _process(delta):
	pass
