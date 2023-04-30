extends Panel

var window_answer
var current_thread
var received = load("res://scenes/message_received.tscn")
var sent = load("res://scenes/message_sent.tscn")

func _ready():
	window_answer = get_tree().get_first_node_in_group("answers")

func _process(delta):
	visible = current_thread != null

func fill_thread(thread):
	clear_thread()
	current_thread = thread
	for message in thread["messages"]:
		var new
		if message["type"] == "sent":
			new = sent.instantiate()
		if message["type"] == "received":
			new = received.instantiate()
		new.text = message["text"]
		new.meta_clicked.connect(keyword_clicked)
		$MarginContainer/ScrollContainer/message_list.add_child(new)

func clear_thread():
	for i in range(0, $MarginContainer/ScrollContainer/message_list.get_child_count()):
		$MarginContainer/ScrollContainer/message_list.get_child(i).queue_free()
	self.current_thread = null

func keyword_clicked(test):
	window_answer.add_answers(current_thread["messages"][-1]["choices"])
