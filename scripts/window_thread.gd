extends Panel

@export_color_no_alpha var text_color : Color
@export_color_no_alpha var background_color_editable : Color
@export_color_no_alpha var background_color_validated : Color

var window_answer
var current_thread
var received = load("res://scenes/message_received.tscn")
var sent = load("res://scenes/message_sent.tscn")
var window_tuto = load("res://scenes/window_tuto.tscn")
var message_list

var opened_windows = []

func _ready():
	window_answer = get_tree().get_first_node_in_group("answers")
	message_list = $VBoxContainer/MarginContainer/ScrollContainer/message_list

func _process(delta):
	visible = current_thread != null

func fill_thread(thread):
	clear()
	if StaticData.is_tutorial_on:
		create_tutorial_window("TUTO_CLICK_ORIGINAL", $position_tuto1.position)
	current_thread = thread
	fill_messages()
	#$AnimationPlayer.play("load_thread")
	var title = TranslationServer.translate("CONVERSATION_BETWEEN").format([thread.receiver, thread.sender])
	$VBoxContainer/border/window_title.text = title

func fill_messages():
	for message in current_thread["messages"]:
		var validated = message.has("validated") and message.has("validated") == true
		var new
		if message["type"] == "sent":
			new = sent.instantiate()
		if message["type"] == "received":
			new = received.instantiate()
		if typeof(message["text"]) == TYPE_STRING:
			new.text = message["text"]
		else:
			# setup editable text
			if !message.has("choice"):
				message["choice"] = message["choices"].keys()[0]
			new.clear()
			new.add_text(message["text"][0].strip_edges() + ' ')
			new.push_color(text_color)
			new.push_bgcolor(background_color_validated if validated else background_color_editable)
			if !validated:
				new.push_meta(message["choice"])
			new.add_text(message["choice"])
			new.pop()
			new.pop()
			if !validated:
				new.pop()
			new.add_text(' ' + message["text"][1].strip_edges())
			new.meta_clicked.connect(keyword_clicked)
			new.meta_underlined = false
		message_list.add_child(new)

func clear():
	clear_message_list()
	for i in opened_windows:
		i.queue_free()
	opened_windows = []
	self.current_thread = null

func clear_message_list():
	for i in range(0, message_list.get_child_count()):
		message_list.get_child(i).queue_free()

func keyword_clicked(new_choice):
	# tuto
	if StaticData.is_tutorial_on:
		create_tutorial_window("TUTO_CLICK_CHOICE", $position_tuto2.position)
	#
	if !window_answer.has_choices():
		StaticSfx.play_sfx(StaticSfx.click32_sfx, randf_range(0.9, 1.1))
		window_answer.add_answers(current_thread["messages"][-1]["choices"])
		window_answer.refresh_answers(new_choice)

func update_choice(choice):
	if StaticData.is_tutorial_on:
		create_tutorial_window("TUTO_CLICK_SEND", $position_tuto3.position)
	current_thread["messages"][-1]["choice"] = choice
	# refresh only messages
	clear_message_list()
	fill_messages()
	window_answer.refresh_answers(choice)

func refresh():
	clear_message_list()
	fill_thread(current_thread)

func get_current_choice():
	return current_thread["messages"][-1]["choices"][current_thread["messages"][-1]["choice"]]

func lock_choice():
	current_thread["messages"][-1]["validated"] = true

func create_tutorial_window(text : String, position : Vector2):
	for i in opened_windows:
		if i.get_text() == text:
			return
	var tuto = window_tuto.instantiate()
	tuto.position = position
	opened_windows.append(tuto)
	self.add_sibling(tuto)
	tuto.open(text)

func _on_close_window_button_pressed():
	StaticSfx.play_sfx(StaticSfx.click31_sfx, 0.8)
	clear()
	window_answer.clear()
