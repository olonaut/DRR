# The player needs to be destroy-able and still keep track of HP and stuff.
# So this is what this script does.

extends Node2D

export var health : int;

var healthContainer;
var healthRes = preload('res://prefabs/Heart.tscn');
var playerRes = preload('res://prefabs/Player.tscn');
var activePlayer;

func _ready():
	healthContainer = get_node("UIContainer/VBoxContainer/HealthContainer");
	spawnPlayer();
	updateHealth();

func playerDied():
	print_debug("player has died");
	health -= 1;
	updateHealth();
	# todo respawn
	
func spawnPlayer():
	var activePlayer = playerRes.instance();
	add_child(activePlayer);

func updateHealth():
	for n in healthContainer.get_children():
		healthContainer.remove_child(n);
		n.queue_free();
		
	for n in health:
		healthContainer.add_child(healthRes.instance());
