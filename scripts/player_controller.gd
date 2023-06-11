# The player needs to be destroy-able and still keep track of HP and stuff.

extends Node2D

@export var health : int;
@export var respawnTimeout : float;
@export var invulnTimeout : float;

var healthContainer;
var healthRes = preload('res://prefabs/Heart.tscn');
var playerRes = preload('res://prefabs/Player.tscn');
var activePlayer;
var isAlive : bool;

func _ready():
	healthContainer = get_node("UIContainer/VBoxContainer/HealthContainer");
	spawnPlayer();
	updateHealth();

func playerDied():
	print_debug("player has died");
	health -= 1;
	updateHealth();
	isAlive = false;
	
	var t = Timer.new()
	t.set_wait_time(respawnTimeout)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout

	if (health > 0):
		spawnPlayer();
	
func _process(delta):
	pass;
	
func spawnPlayer():
	var activePlayer = playerRes.instantiate();
	add_child(activePlayer);
	isAlive = true;
	activePlayer.invuln = true
	
	var t = Timer.new()
	t.set_wait_time(invulnTimeout)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout

	activePlayer.invuln = false;

func updateHealth():
	for n in healthContainer.get_children():
		healthContainer.remove_child(n);
		n.queue_free();
	for n in health:
		healthContainer.add_child(healthRes.instantiate());
