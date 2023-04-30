extends Control

var password_try_count = 0
var tween
var max_attempt = 3

func _ready():
	$AnimationPlayer.play("system_start", -1, 1.5)


func _process(delta):
	$time.text =  Time.get_time_string_from_system().substr(0, 5)
	$password.grab_focus()


func _on_password_text_submitted(new_text):
	if $AnimationPlayer.is_playing() or tween and tween.is_running:
		return
	password_try_count += 1
	print("try " + str(password_try_count))
	if password_try_count < max_attempt:
		$password.text = ""
		$AnimationPlayer.play("authentification_failed")
		$warning.text = "Wrong Password, {0} attempts left".format([max_attempt - password_try_count])
	else:
		$warning.text = ""
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "position", Vector2(0, -self.size.y), 2)
