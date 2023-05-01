extends VBoxContainer
var origin
var distance = 500
var popup = load("res://scenes/popup_info_news.tscn")

func _ready():
	$start_timer.start(1)
	origin = self.position
	self.position.x = self.position.x+500



func _process(delta):
	if !$end_timer.is_stopped():
		self.position.x = origin.x + 1000 * (1 - $end_timer.time_left)
	if !$start_timer.is_stopped() && self.position.x > origin.x:
		self.position.x = self.position.x - 1000 * (1 - $start_timer.time_left)


func _on_texture_button_pressed():
	$end_timer.start(1)
	origin = self.position
	$start_timer.stop()




func _on_end_timer_timeout():
	self.queue_free()

