extends Control

var threads

var preview_window
var thread_window
var answer_window
var time_field

func _ready():
	threads = StaticData.threads
	preview_window = get_tree().get_first_node_in_group("preview")
	thread_window = get_tree().get_first_node_in_group("thread")
	answer_window = get_tree().get_first_node_in_group("answers")
	time_field = get_tree().get_first_node_in_group("time")
	create_event(threads[0])


func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	if time_field != null:
		time_field.text = current_time

func create_event(thread):
	preview_window.create_com_event(thread)


func _on_send_button_pressed():
	thread_window.clear_thread()
	answer_window.clear()

