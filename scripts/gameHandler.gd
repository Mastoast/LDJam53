extends Control

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
	threads = StaticData.threads
	preview_window = get_tree().get_first_node_in_group("preview")
	thread_window = get_tree().get_first_node_in_group("thread")
	answer_window = get_tree().get_first_node_in_group("answers")
	time_field = get_tree().get_first_node_in_group("time")

	create_event(threads[0])
	article_list = StaticData.info_threads


func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	if time_field != null:
		time_field.text = current_time

func create_event(thread):
	preview_window.create_com_event(thread)

func _on_send_button_pressed():
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
			create_popup(press_article, $arrive_popup.position)
	if ("trip_pool" in decisions or "trip_ski" in decisions) && not("trip_museum" in news):
			press_article = article_list[1]
			news.append("trip_museum")
			create_popup(press_article, $arrive_popup.position)
	if "driver_museum" in decisions && !("driver_museum" in news):
			press_article = article_list[2]
			news.append("driver_museum")
			create_popup(press_article, $arrive_popup.position)
	if "driver_casino" in decisions && !("driver_casino" in news):
			press_article = article_list[3]
			news.append("driver_casino")
			create_popup(press_article, $arrive_popup.position)
	if "oyster_food_bank" in decisions && !("oyster_food_bank" in news):
			press_article = article_list[4]
			news.append("oyster_food_bank")
			create_popup(press_article, $arrive_popup.position)
	if "police_zoo" in decisions && !("police_zoo" in news):
			press_article = article_list[5]
			news.append("police_zoo")
			create_popup(press_article, $arrive_popup.position)
	if "robber_10" in decisions && !("robber_10" in news):
			press_article = article_list[6]
			news.append("robber_10")
			create_popup(press_article, $arrive_popup.position)
	if "police_land_robber" in decisions && !("police_land_robber" in news):
			press_article = article_list[7]
			news.append("police_land_robber")
			create_popup(press_article, $arrive_popup.position)

func create_popup(press_article, position):
	var new_popup = popup.instantiate()
	print('info news')
	new_popup.global_position = position
	new_popup.get_node('ColorRect/VBoxContainer/title').text = press_article["title"]
	new_popup.get_node('ColorRect/VBoxContainer/content').text = press_article["content"]
	
	# ERROR ICI
	# Timer was not added to the SceneTree.
	# Either add it or set autostart to true.
	await get_tree().create_timer(5.0).timeout
	self.add_child(new_popup)
	#timer.connect("timeout", self._on_timer_timeout(new_popup))

func _on_timer_timeout(new_popup) -> void:
	self.add_child(new_popup)
