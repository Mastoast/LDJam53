extends Panel

var thread
var preview_message = load("res://scenes/preview_message.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_com_event(thread):
	self.thread = thread
	var new_event = preview_message.instantiate()
	new_event.init(thread)
	new_event.get_node('VBoxContainer/character_name').text = thread["sender"]
	new_event.get_node('VBoxContainer/message_overview').text = thread["messages"][0]["text"]
	$VBoxContainer/MarginContainer/ScrollContainer/event_list.add_child(new_event)
