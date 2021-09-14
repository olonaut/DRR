# The player needs to be destroy-able and still keep track of HP and stuff.
# So this is what this script does.

extends Node2D

export var health : int;

var playerRes = preload('res://prefabs/Player.tscn')
var activePlayer;

func _ready():
	spawnPlayer();

func playerDied():
	print_debug("player has died")
	# todo deduct health
	# todo respawn
	
func spawnPlayer():
	var activePlayer = playerRes.instance()
	add_child(activePlayer)	
