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
		new.text = message["text"] if typeof(message["text"]) == TYPE_STRING else message["text"][0]
		new.meta_clicked.connect(keyword_clicked)
		$MarginContainer/ScrollContainer/message_list.add_child(new)

func clear_thread():
	for i in range(0, $MarginContainer/ScrollContainer/message_list.get_child_count()):
		$MarginContainer/ScrollContainer/message_list.get_child(i).queue_free()
	self.current_thread = null

func keyword_clicked(current_choice):
	window_answer.add_answers(current_thread["messages"][-1]["choices"])
	window_answer.refresh_answers(current_choice)

func update_choice(choice):
	current_thread["messages"][-1]["text"] += choice
	refresh()
	window_answer.refresh_answers(choice)
	

func refresh():
	fill_thread(current_thread)

