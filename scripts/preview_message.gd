extends Button

var thread

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func init(thread):
	self.thread = thread

func _on_pressed():
	get_tree().get_first_node_in_group("thread").fill_thread(thread)
