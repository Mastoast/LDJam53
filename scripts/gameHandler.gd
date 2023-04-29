extends Control



func _ready():
	pass



func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	$VBoxContainer/head/MarginContainer/HBoxContainer/time.text = current_time
	
