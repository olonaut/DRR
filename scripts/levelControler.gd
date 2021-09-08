extends Node2D

class_name levelControler

var music : Node;
export var bgMusic : AudioStream;
var objSpawn : ReferenceRect
var objects = [preload('res://prefabs/Obj1.tscn')]

# level variables
# this is mostly stuff for spawning enemies
export var isActive : bool;	# we want the level to stop when the player dies for ex.
export var stage : int; 	# this controls the boss and the type of objects
export var totalWaves : int;	# number of waves
export var objPerWave : int;	# number of objects per wave
export var waveDelay : float; 	# how long to wait between waves
export var objDelay : float;	# time between objects

# keeping track
var waveActive : bool = false;
var waveNo : int = 0;
var waveDelta : float = 0.0;

# misc and utilities
var rng = RandomNumberGenerator.new()

func _ready():
	# get object spawn area
	objSpawn = get_node("ObjSpawn");
	# play music
	music = get_tree().root.get_node("BgMusic");
	music.stop(); # this is technically not necessary but.. you know. just in case.
	music.stream = bgMusic;
	music.play();
	rng.randomize();

func _process(delta):
	if waveNo <= totalWaves:
		if isActive:
			if waveActive == false:
				waveDelta += delta;
				if waveDelta >= waveDelay:
					wave();

func wave():
	waveNo += 1
	print_debug("wave " + str(waveNo))
	var t = Timer.new()
	t.set_wait_time(objDelay)
	t.set_one_shot(true)
	self.add_child(t)
	
	waveActive = true;
	for i in objPerWave:
		spawnObj();
		t.start()
		yield(t, "timeout")

	print_debug("wave ends")
	waveActive = false;
	waveDelta = 0.0;

func spawnObj():
	# generate and calculate position
	var pos_offset : Vector2 = Vector2(rng.randi_range(0,objSpawn.rect_size.x),0)
	var pos : Vector2 = objSpawn.rect_position + pos_offset
	var _obj = objects[0].instance()
	_obj.position = pos;
	add_child(_obj)
	
