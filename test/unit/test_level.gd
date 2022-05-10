extends "res://addons/gut/test.gd"

var Level = load("res://scripts/level_controller.gd");

func test_level():
	var _level = Level.new()
	assert_file_exists(_level._level_file_path)
	assert_file_not_empty(_level._level_file_path)
	_level._ready()
