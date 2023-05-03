extends Button

var thread
var thread_window
var answers_window

func _ready():
	thread_window = get_tree().get_first_node_in_group("thread")
	answers_window = get_tree().get_first_node_in_group("answers")

func _process(delta):
	if thread and self.has_theme_stylebox_override("normal") and thread["messages"][-1].has("validated"):
		self.remove_theme_stylebox_override("normal")
		self.remove_theme_stylebox_override("focus")
		self.remove_theme_stylebox_override("hover")
		self.remove_theme_stylebox_override("pressed")

func init(thread):
	self.thread = thread

func _on_pressed():
	if thread_window.current_thread != thread:
		answers_window.clear()
		thread_window.fill_thread(thread)
		StaticSfx.play_sfx(StaticSfx.click2_sfx, randf_range(0.9, 1.1))
