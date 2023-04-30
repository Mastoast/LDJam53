extends Panel

var received = load("res://scenes/message_received.tscn")
var sent = load("res://scenes/message_sent.tscn")

func _ready():
	pass


func _process(delta):
	pass

func fill_thread(thread):
	clear_thread()
	for message in thread["messages"]:
		var new
		if message["type"] == "sent":
			new = sent.instantiate()
		if message["type"] == "received":
			new = received.instantiate()
		new.text = message["text"]
		$MarginContainer/ScrollContainer/message_list.add_child(new)

func clear_thread():
	for i in range(0, $MarginContainer/ScrollContainer/message_list.get_child_count()):
		$MarginContainer/ScrollContainer/message_list.get_child(i).queue_free()
