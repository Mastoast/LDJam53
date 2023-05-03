extends Panel

var thread
var message_preview = load("res://scenes/message_preview.tscn")

func _ready():
	pass

func _process(delta):
	pass

func create_com_event(thread):
	self.thread = thread
	var new_event = message_preview.instantiate()
	new_event.init(thread)
	new_event.get_node('VBoxContainer/character_name').text = thread["receiver"]
	new_event.get_node('VBoxContainer/message_overview').text = thread["messages"][0]["text"]
	$VBoxContainer/MarginContainer/ScrollContainer/event_list.add_child(new_event)
