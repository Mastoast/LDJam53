extends Control

@export_range(0.0, 20.0, 0.1) var info_creation_delay : float = 5.0

var threads
var article_list = StaticData.info_threads

var preview_window
var thread_window
var answer_window
var time_field
var popup = load("res://scenes/popup_info_news.tscn")

var decisions = []
var news = []
var press_article = {"title":"prout", "content":"patate"}

func _ready():
	preview_window = get_tree().get_first_node_in_group("preview")
	thread_window = get_tree().get_first_node_in_group("thread")
	answer_window = get_tree().get_first_node_in_group("answers")
	time_field = get_tree().get_first_node_in_group("time")

func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	if time_field != null:
		time_field.text = current_time

func load_threads():
	threads = StaticData.threads
	create_event(threads[0])
	article_list = StaticData.info_threads

func create_event(thread):
	preview_window.create_com_event(thread)

func _on_send_button_pressed():
	var tuto1 = get_tree().current_scene.find_child("tuto1")
	tuto1.visible = false
	var tuto2 = get_tree().current_scene.find_child("tuto2")
	tuto2.visible = false
	#
	StaticSfx.play_sfx(StaticSfx.success_sfx, randf_range(0.90, 0.95), 0.55)
	var new_choice = thread_window.get_current_choice()
	thread_window.lock_choice()
	thread_window.clear_thread()
	answer_window.clear()
	decisions.append(new_choice)
	print(decisions)
	#
	popup_check(new_choice)
	add_message(decisions)

func add_message(decisions):
	var next_message

	while decisions.size() < threads.size():
		next_message = threads[decisions.size()]
		if next_message["sender"] == "CEO Land Robber":
			if "eviction_land" in decisions:
				create_event(next_message)
				return
			else:
				decisions.append("embez_none")
		elif next_message["sender"] == "Mom":
			if "oyster_friend" in decisions:
				create_event(next_message)
				return
			else:
				decisions.append("mom_none")
		elif next_message["sender"] == "Tourism bus driver":
			if "robber_10" in decisions:
				if next_message["version"] == "investigation":
					decisions.append("filler_for_driver")
				else: 
					create_event(next_message)
					return
			else: 
				if next_message["version"] == "zoo":
					decisions.append("filler_for_driver")
				else: 
					create_event(next_message)
					return
		else:
			create_event(next_message)
			return

func popup_check(choice):
	if choice == "eviction_ice" and "eviction_ice" in decisions:
		create_news("eviction_ice", article_list[0])
	if choice == "trip_museum" && ("trip_pool" in decisions or "trip_ski" in decisions):
		create_news("trip_museum", article_list[1])
	if choice == "driver_museum":
		create_news("driver_museum", article_list[2])
	if choice == "driver_casino":
		create_news("driver_casino", article_list[3])
	if choice == "oyster_food_bank":
		create_news("oyster_food_bank", article_list[4])
	if choice == "police_zoo":
		create_news("police_zoo", article_list[5])
	if choice == "robber_10":
		create_news("robber_10", article_list[6])
	if choice == "police_land_robber":
		create_news("police_land_robber", article_list[7])

func create_news(name, press_article):
	news.append(name)
	create_popup(press_article)

func create_popup(press_article):
	var new_popup = popup.instantiate()
	print('info news')
	new_popup.get_node('ColorRect/VBoxContainer/title').text = press_article["title"]
	new_popup.get_node('ColorRect/VBoxContainer/content').text = press_article["content"]
	new_popup.global_position = $depart_popup.position
	new_popup.destination = Vector2($depart_popup.position.x - new_popup.size.x, new_popup.position.y) 
	
	await get_tree().create_timer(info_creation_delay).timeout
	self.add_child(new_popup)
