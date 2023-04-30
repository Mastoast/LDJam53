extends MarginContainer

var answer_button = load("res://scenes/answer_button.tscn")

func _ready():
	pass


func _process(delta):
	visible = $HBoxContainer.get_child_count() > 0

func add_answers(choices):
	clear()
	for answer in choices:
		var new = answer_button.instantiate()
		new.text = answer
		$HBoxContainer.add_child(new)

func clear():
	for i in range(0, $HBoxContainer.get_child_count()):
		$HBoxContainer.get_child(i).queue_free()
