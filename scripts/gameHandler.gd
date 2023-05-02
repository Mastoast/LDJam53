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
	#load_threads()

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
	StaticData.play_sfx(StaticData.success_sfx, randf_range(0.90, 0.95), 0.55)
	var new_choice = thread_window.get_current_choice()
	thread_window.lock_choice()
	decisions.append(new_choice)
	thread_window.clear_thread()
	answer_window.clear()
	add_message(decisions)
	print(decisions)

func add_message(decisions):
	var next_message
	popup_check(decisions)

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

func popup_check(decisions):
	if "eviction_ice" in decisions && !("eviction_ice" in news):
			press_article = article_list[0]
			news.append("eviction_ice")
			create_popup(press_article)
	if ("trip_pool" in decisions or "trip_ski" in decisions) && not("trip_museum" in news):
			press_article = article_list[1]
			news.append("trip_museum")
			create_popup(press_article)
	if "driver_museum" in decisions && !("driver_museum" in news):
			press_article = article_list[2]
			news.append("driver_museum")
			create_popup(press_article)
	if "driver_casino" in decisions && !("driver_casino" in news):
			press_article = article_list[3]
			news.append("driver_casino")
			create_popup(press_article)
	if "oyster_food_bank" in decisions && !("oyster_food_bank" in news):
			press_article = article_list[4]
			news.append("oyster_food_bank")
			create_popup(press_article)
	if "police_zoo" in decisions && !("police_zoo" in news):
			press_article = article_list[5]
			news.append("police_zoo")
			create_popup(press_article)
	if "robber_10" in decisions && !("robber_10" in news):
			press_article = article_list[6]
			news.append("robber_10")
			create_popup(press_article)
	if "police_land_robber" in decisions && !("police_land_robber" in news):
			press_article = article_list[7]
			news.append("police_land_robber")
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
