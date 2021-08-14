extends Node2D

var music : Node;
export var bgMusic : AudioStream;

func _ready():
	# play music
	music = get_tree().root.get_node("BgMusic");
	music.stop(); # this is technically not necessary but.. you know. just in case.
	music.stream = bgMusic;
	music.play();

func _process(delta):

	pass
