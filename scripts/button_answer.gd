extends Button

var window_thread

func _ready():
	window_thread = get_tree().get_first_node_in_group("thread")

func _process(delta):
	pass

func _on_pressed():
	window_thread.update_choice($Label.text)

func get_label():
	return $Label.text

func set_label(text):
	$Label.text = text

func _on_button_down():
	StaticSfx.play_sfx(StaticSfx.click31_sfx, randf_range(0.9, 1.1))

func _on_button_up():
	StaticSfx.play_sfx(StaticSfx.click32_sfx, randf_range(0.9, 1.1))
