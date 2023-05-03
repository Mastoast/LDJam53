extends MarginContainer

var window_thread
var button_answer = load("res://scenes/button_answer.tscn")

func _ready():
	window_thread = get_tree().get_first_node_in_group("thread")


func _process(delta):
	visible = $HBoxContainer.get_child_count() > 0

func add_answers(choices):
	clear()
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	for choice in choices:
		var new = button_answer.instantiate()
		new.set_label(choice)
		$HBoxContainer.add_child(new)
		tween.tween_property(new, "custom_minimum_size", new.custom_minimum_size, 0.05)
		new.custom_minimum_size = new.custom_minimum_size * 0.85

func has_choices():
	return $HBoxContainer.get_child_count() > 0

func refresh_answers(current_choice):
	for choice in $HBoxContainer.get_children():
		choice.disabled = choice.get_label() == current_choice

func clear():
	for i in range(0, $HBoxContainer.get_child_count()):
		$HBoxContainer.get_child(i).queue_free()

