extends Button

var window_thread

func _ready():
	window_thread = get_tree().get_first_node_in_group("thread")


func _process(delta):
	pass

func _on_pressed():
	StaticData.play_sfx(StaticData.click3_sfx, randf_range(0.9, 1.1))
	window_thread.update_choice($Label.text)

func get_label():
	return $Label.text

func set_label(text):
	$Label.text = text

