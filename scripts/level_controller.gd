# Level Controller
# - The Level is made up of Stages
# - Stages are defined by Waves
# - Waves spawn Objects
extends Node2D

class_name levelControler

# music stuff
var music : Node;
export var bgMusic : AudioStream;

# references to other objects
var objSpawn : ReferenceRect;
var objects = [preload('res://prefabs/Obj1.tscn'),preload('res://prefabs/Obj2.tscn')];
var bossController : Node2D;

# JSON stuff
var _level_file = File.new();
var _level_file_path = 'res://data/levels.json';
var level_data

# level variables
# this is mostly stuff for spawning enemies
export var isActive : bool;			# we want the level to stop when the player dies for ex.

# the actual levels
var levels_dict : Array = [];

# keeping track of stuff
var waveActive : bool = false;
var waveDelta : float = 0.0;
var waveNo : int = 0;
var stageNo : int = 0;

var chanceObjMap : Array = [];

# misc and utilities
var rng = RandomNumberGenerator.new();

func _ready():
	# get object spawn area
	objSpawn = get_node("ObjSpawn");
	
	# Get Boss controller
	bossController = get_node("BossController")

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
	
	stageInit();
	
func _process(delta):
	if stageNo < level_data.size():
		if isActive:
			if waveNo < level_data[stageNo]["waves"]:
				if waveActive == false:
					waveDelta += delta;
					if waveDelta >= level_data[stageNo]["waveDelay"]:
						wave();
			else:
				waveNo = 0
				stageNo += 1
	else: # after all stages and waves have passed...
		bossController.start();
		#todo spawn boss

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
	var _obj = objects[int(chanceObjMap[rng.randi_range(0,9)])].instance()
	_obj.position = pos;
	add_child(_obj)

func stageInit():
	# populate the chanceObjMap array
	var _mapindex = 0;
	print_debug("populating...")
	for obj in level_data[stageNo].objects:
		print_debug("object" + str(obj) + " has a chance of " + str(level_data[stageNo].objects[obj]) + " / 10");
		for i in level_data[stageNo].objects[obj]:
			chanceObjMap.append(obj);
			_mapindex += 1;
	print_debug(str(chanceObjMap))
	
	# now we can generate a random number with max length of the array, and use the result as the index of the array. this gives us the object to be used
