extends Node

# Reference to the local label node
var label;
var slider;

# Constants for range conversion
var maxDB = 0;
var minDB = -72;

@export var bus : int;

func _ready():
	for n in get_children():
		if n.name == "value":
			print_debug("found value label");
			label = n;
		elif n.name == "HSlider":
			print_debug("found slider node");
			slider = n;
	
	# Set percentage to current volume
	var currentVol = convertDbToPercent(AudioServer.get_bus_volume_db(bus));
	slider.value = currentVol;
	label.text = str(currentVol) + "%";
	# Set slider to editable.
	# It is disabled by default to avoid a race condition
	slider.editable = true;

func _on_HSlider_value_changed(value):
	label.text = str(value) + "%"
	AudioServer.set_bus_volume_db(bus, convertPercentToDb(value));
	
# Convert percent into dB range
func convertPercentToDb(oldVal):
	return ((oldVal * (maxDB - minDB) ) / 100 ) + minDB;

# convert dB into Percent
func convertDbToPercent(oldVal):
	return (((oldVal - minDB) * 100) / (minDB*-1))
