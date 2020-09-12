extends Node2D

var music : Node;
export var bgMusic : AudioStream;

func _ready():
	music = get_tree().root.get_node("BgMusic");
	music.stop();
	music.stream = bgMusic;
	music.play();
