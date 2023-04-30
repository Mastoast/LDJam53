extends MarginContainer



func _ready():
	pass


func _process(delta):
	visible = $HBoxContainer.get_child_count() > 0

func clear():
	for i in range(0, $HBoxContainer.get_child_count()):
		$HBoxContainer.get_child(i).queue_free()
