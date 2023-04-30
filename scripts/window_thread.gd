extends Panel

@export_color_no_alpha var text_color : Color
@export_color_no_alpha var background_color : Color

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
		if typeof(message["text"]) == TYPE_STRING:
			new.text = message["text"]
		else:
			# setup changeable text
			new.clear()
			new.add_text(message["text"][0].strip_edges() + ' ')
			new.push_color(text_color)
			new.push_bgcolor(background_color)
			new.push_meta("test")
			new.add_text(message["choices"][0])
			new.pop()
			new.pop()
			new.pop()
			new.add_text(' ' + message["text"][1].strip_edges())
			new.meta_clicked.connect(keyword_clicked)
			new.meta_underlined = false
		$MarginContainer/ScrollContainer/message_list.add_child(new)

func clear_thread():
	for i in range(0, $MarginContainer/ScrollContainer/message_list.get_child_count()):
		$MarginContainer/ScrollContainer/message_list.get_child(i).queue_free()
	self.current_thread = null

func keyword_clicked(current_choice):
	window_answer.add_answers(current_thread["messages"][-1]["choices"])
	window_answer.refresh_answers(current_choice)

func update_choice(choice):
#	current_thread["messages"][-1]["text"] += choice
	refresh()
	window_answer.refresh_answers(choice)
	

func refresh():
	fill_thread(current_thread)

