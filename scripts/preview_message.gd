extends Button

var thread
var thread_window
var answers_window

func _ready():
	thread_window = get_tree().get_first_node_in_group("thread")
	answers_window = get_tree().get_first_node_in_group("answers")

func _process(delta):
	pass

func init(thread):
	self.thread = thread

func _on_pressed():
	if thread_window.current_thread != thread:
		answers_window.clear()
		thread_window.fill_thread(thread)
