extends Panel

var event = load("res://scenes/communication_event.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_com_event(sender, receiver, messages):
	var new_event = event.instantiate()
	new_event.get_node('VBoxContainer/character_name').text = sender
	#new_event.VBoxContainer.character_name.text = sender
	new_event.get_node('VBoxContainer/message_overview').text = messages[0]["text"]
	
	
	$MarginContainer/VBoxContainer/ScrollContainer/event_list.add_child(new_event)
