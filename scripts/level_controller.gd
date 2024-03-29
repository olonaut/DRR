# Level Controller
# - The Level is made up of Stages
# - Stages are defined by Waves
# - Waves spawn Objects
extends Node2D

class_name levelControler

# music stuff
var music : Node
export var bgMusic : AudioStream

# references to other objects
var objSpawn : ReferenceRect
var objects = [preload('res://prefabs/Obj1.tscn'),preload('res://prefabs/Obj2.tscn')]
var bossController : Node2D
var pausePopup : PopupMenu
# JSON stuff
var _level_file = File.new()
var _level_file_path = 'res://data/levels.json'
var level_data

# level variables
# this is mostly stuff for spawning enemies
export var isActive : bool			# we want the level to stop when the player dies for ex.

# the actual levels
var levels_dict : Array = []

# keeping track of stuff
var waveActive : bool = false
var waveDelta : float = 0.0
var waveNo : int = 0
var stageNo : int = 0
var state : int = 0

var chanceObjMap : Array = []

# cheat stuff ;)
var cheat_bossskip = "boss"
var cheat_map = "    "

# misc and utilities
var rng = RandomNumberGenerator.new()

func _ready():
	# get object spawn area
	objSpawn = get_node("ObjSpawn")
	
	# Get Boss controller
	bossController = get_node("BossController")

	# Get Pause Popup
	pausePopup = get_node("PausePopup")

	# play music
	music = get_tree().root.get_node("BgMusic")
	music.stop() # this is technically not necessary but.. you know. just in case.
	music.stream = bgMusic
	music.play()
	rng.randomize()
	
	# JSON stuff
	_level_file.open(_level_file_path, File.READ)
	var _level_data_raw = _level_file.get_as_text()
	_level_file.close()
	var _level_parse = JSON.parse(_level_data_raw)
	level_data = _level_parse.result
	
	stageInit()

func _process(delta):
	if Input.is_action_just_released("ui_menu"):
		print_debug("pause");
		pausePopup.popup_centered()
		get_tree().paused = not get_tree().paused
	
	if stageNo < level_data.size():
		if isActive:
			if waveNo < level_data[stageNo]["waves"]:
				if waveActive == false:
					waveDelta += delta
					if waveDelta >= level_data[stageNo]["waveDelay"]:
						wave()
			else:
				waveNo = 0
				stageNo += 1
	else: # after all stages and waves have passed...
		if state == 0 && waveActive == false:
			state = 1
			startBoss()
		
func wave():
	waveNo += 1
	print_debug("wave " + str(waveNo))
	var t = Timer.new()
	t.set_wait_time(level_data[stageNo]["objDelay"])
	t.set_one_shot(true)
	self.add_child(t)
	
	waveActive = true
	for i in level_data[stageNo]["objPerWave"]:
		spawnObj()
		t.start()
		yield(t, "timeout")

	print_debug("wave ends")
	waveActive = false
	waveDelta = 0.0

func spawnObj():
	var pos_offset : Vector2 = Vector2(rng.randi_range(0,objSpawn.rect_size.x),0)
	var pos : Vector2 = objSpawn.rect_position + pos_offset
	var _obj = objects[int(chanceObjMap[rng.randi_range(0,9)])].instance()
	_obj.position = pos
	add_child(_obj)

func stageInit():
	# populate the chanceObjMap array
	var _mapindex = 0
	print_debug("populating...")
	for obj in level_data[stageNo].objects:
		print_debug("object" + str(obj) + " has a chance of " + str(level_data[stageNo].objects[obj]) + " / 10")
		for i in level_data[stageNo].objects[obj]:
			chanceObjMap.append(obj)
			_mapindex += 1
	print_debug(str(chanceObjMap))

func startBoss():
	# wait 3 seconds
	print_debug("starting timer")
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	print_debug("timer over")

	# todo add object burst
	bossController.start()

func cheat_processor(scancode):
	cheat_map += scancode
	cheat_map.erase(0,1)
	if cheat_map == cheat_bossskip:
		print_debug("Cheat Active: BOSS SKIP")
		waveActive = false
		state = 1
		stageNo = level_data.size()
		startBoss()
	pass

func _input(ev):
	if ev is InputEventKey and ev.pressed:
		cheat_processor(char(ev.unicode))
	pass
