extends Control

var password_try_count = 0

func _ready():
	$AnimationPlayer.play("system_start")


func _process(delta):
	var current_time = Time.get_time_dict_from_system()
	$time.text = str(current_time.hour) + ":" + str(current_time.minute)
	#
	$password.grab_focus()


func _on_password_text_submitted(new_text):
	password_try_count += 1
	if password_try_count >= 3:
		# start game
		pass
