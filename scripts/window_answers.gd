extends MarginContainer

var window_thread
var answer_button = load("res://scenes/answer_button.tscn")

func _ready():
	window_thread = get_tree().get_first_node_in_group("thread")


func _process(delta):
	visible = $HBoxContainer.get_child_count() > 0

func add_answers(choices):
	clear()
	for choice in choices:
		var new = answer_button.instantiate()
		new.text = choice
		$HBoxContainer.add_child(new)

func refresh_answers(current_choice):
	for choice in $HBoxContainer.get_children():
		choice.disabled = choice.text == current_choice

func clear():
	for i in range(0, $HBoxContainer.get_child_count()):
		$HBoxContainer.get_child(i).queue_free()

