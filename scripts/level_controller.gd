# Level Controller
# - The Level is made up of Stages
# - Stages are defined by Waves
# - Waves spawn Objects
extends Node2D

class_name levelControler

var music : Node;
export var bgMusic : AudioStream;
var objSpawn : ReferenceRect;
var objects = [preload('res://prefabs/Obj1.tscn'),preload('res://prefabs/Obj2.tscn')];

# JSON stuff
var _level_file = File.new();
var _level_file_path = 'res://data/levels.json';
var level_data

# level variables
# this is mostly stuff for spawning enemies
export var isActive : bool;			# we want the level to stop when the player dies for ex.
export var phase : int; 			# 0 = normal game, 1 = boss

# the actual levels
var levels_dict : Array = [];

# keeping track of stuff
var waveActive : bool = false;
var waveNo : int = 0;
var waveDelta : float = 0.0;
var stageNo : int = 0;

# misc and utilities
var rng = RandomNumberGenerator.new();

func _ready():
	# get object spawn area
	objSpawn = get_node("ObjSpawn");
	# play music
	music = get_tree().root.get_node("BgMusic");
	music.stop(); # this is technically not necessary but.. you know. just in case.
	music.stream = bgMusic;
	music.play();
	rng.randomize();
	
	# JSON stuff
	_level_file.open(_level_file_path, File.READ);
	var _level_data_raw = _level_file.get_as_text();
	_level_file.close();
	var _level_parse = JSON.parse(_level_data_raw)
	level_data = _level_parse.result
	#deteleme	
	print_debug(str(level_data[waveNo].objects))

func _process(delta):
	if waveNo < level_data[stageNo]["waves"]:
		if isActive:
			if waveActive == false:
				waveDelta += delta;
				if waveDelta >= level_data[stageNo]["waveDelay"]:
					wave();

func wave():
	waveNo += 1
	print_debug("wave " + str(waveNo))
	var t = Timer.new()
	t.set_wait_time(level_data[stageNo]["objDelay"])
	t.set_one_shot(true)
	self.add_child(t)
	
	waveActive = true;
	for i in level_data[stageNo]["objPerWave"]:
		spawnObj();
		t.start()
		yield(t, "timeout")

	print_debug("wave ends")
	waveActive = false;
	waveDelta = 0.0;

func spawnObj():
	# TODO roll object from chance
	# generate and calculate position
	var pos_offset : Vector2 = Vector2(rng.randi_range(0,objSpawn.rect_size.x),0)
	var pos : Vector2 = objSpawn.rect_position + pos_offset
	var _obj = objects[0].instance()
	_obj.position = pos;
	add_child(_obj)
