extends Button

var thread_window

func _ready():
	thread_window = get_tree().get_first_node_in_group("thread")


func _process(delta):
	pass
