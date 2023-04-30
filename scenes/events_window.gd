extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	create_com_event()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_com_event():
	var event = load("res://scenes/communication_event.tscn")
	var test = event.instantiate()
	$MarginContainer/VBoxContainer/ScrollContainer/event_list.add_child(test)
