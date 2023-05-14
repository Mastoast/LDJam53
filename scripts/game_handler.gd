extends Control

@export_range(0.0, 20.0, 0.1) var info_creation_delay : float = 5.0

var threads
var article_list = StaticData.info_threads

var preview_window
var thread_window
var answer_window
var time_field
var popup = load("res://scenes/popup_info_news.tscn")

var printed = []
var printed_articles = []
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
	#check for messages to print
	if threads:
		for message in threads:
			var toprint_choice = false
			var toprint_print = false
			if !(message["id"] in printed): 
				for condition in message["conditions"]:
					toprint_choice = true
					toprint_print = true
					if condition["choice_needed"]:
						for choice in condition["choice_needed"]:
							if !(choice in decisions):
								toprint_choice = false
					if condition["print_needed"]:
						for print in condition["print_needed"]:
							toprint_print = false
							for decision in decisions:
								if print == decision.split("_")[0]:
									toprint_print = true
			if toprint_choice && toprint_print :
				printed.append(message["id"])
				print(printed)
				create_event(message)
	checkandprint_news()

func checkandprint_news():
	for article in article_list:
		if !(article["title"] in printed_articles):
			var print_article = true
			print(article)
			for set in article["decision_needed"]:
				var or_condition_test = false
				for or_condition in set:
					if or_condition in decisions:
						or_condition_test = true
				if !or_condition_test:
					print_article = false
			if print_article:
				create_popup(article)
				printed_articles.append(article["title"])
	
func load_threads():
	threads = StaticData.threads
	article_list = StaticData.info_threads

func create_event(thread):
	preview_window.create_com_event(thread)

func _on_send_button_pressed():
	StaticData.is_tutorial_on = false
	StaticSfx.play_sfx(StaticSfx.success_sfx, randf_range(0.90, 0.95), 0.55)
	var new_choice = thread_window.get_current_choice()
	print(thread_window)
	thread_window.lock_choice()
	thread_window.clear()
	answer_window.clear()
	decisions.append(new_choice)
	print(decisions)
	#popup_check(new_choice)
	#add_message(decisions)

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
	new_popup.find_child("title").text = press_article["title"]
	new_popup.find_child("content").text = press_article["content"]
	new_popup.global_position = $depart_popup.position
	new_popup.destination = Vector2($depart_popup.position.x - new_popup.size.x, new_popup.position.y) 
	
	await get_tree().create_timer(info_creation_delay).timeout
	self.add_child(new_popup)
