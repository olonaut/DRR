extends Node2D


var bossPrefab = preload('res://prefabs/Boss.tscn');
var bossInstance;

func start():
	print_debug("Starting...");
	bossInstance = bossPrefab.instance();
	add_child(bossInstance);

