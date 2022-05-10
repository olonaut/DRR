extends "res://addons/gut/test.gd"

var Player = load("res://scripts/player.gd");

func test_player_shot():
	var _player = Player.new();
	print_debug(_player.shot)
	assert_typeof(_player.shot,TYPE_OBJECT)
	assert_not_null(_player.shot)
