extends Button

var thread
var thread_window

func _ready():
	thread_window = get_tree().get_first_node_in_group("thread")

func _process(delta):
	pass

func init(thread):
	self.thread = thread

func _on_pressed():
	thread_window.fill_thread(thread)
