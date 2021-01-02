extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.is_debug_build():
		pass
		#AudioServer.set_bus_volume_db(1, -72)
		
