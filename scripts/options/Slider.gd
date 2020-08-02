extends Node

# Reference to the local slider node
var slider;

# Constants for range conversion
var maxDB = 0;
var minDB = -72;

func _ready():
	for n in get_children():
		if n.name == "value":
			print_debug("found value label");
			slider = n;


func _on_HSlider_value_changed(value,bus):
	slider.text = str(value) + "%"
	AudioServer.set_bus_volume_db(bus, convertRange(value));
	
# Convert 
func convertRange(oldVal):
	var newRange = (maxDB - minDB)
	return ((oldVal * newRange ) / 100 ) + minDB;
