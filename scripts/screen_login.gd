extends Control

@export_range(0, 10, 0.1) var animation_speed : float = 1.0 

var password_try_count = 0
var tween
var max_attempt = 3

var language_index = 0
var languages = ["ENG", "FRA"]

func _ready():
	$AnimationPlayer.play("system_start", -1, animation_speed)
	$password.grab_focus()

func _process(delta):
	$time.text =  Time.get_time_string_from_system().substr(0, 5)

func _on_password_text_submitted(new_text):
	if $AnimationPlayer.is_playing() or tween and tween.is_running:
		return
	password_try_count += 1
	if password_try_count < max_attempt:
		$password.text = ""
		$AnimationPlayer.play("authentification_failed", -1, animation_speed)
		$warning.text = TranslationServer.translate("PASSWORD_WARNING").format([max_attempt - password_try_count])
		StaticSfx.play_sfx(StaticSfx.error_sfx)
	else:
		StaticData.load_threads()
		var game_handler = get_tree().get_first_node_in_group("game")
		game_handler.load_threads()
		$warning.text = ""
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "position", Vector2(0, -self.size.y), 2.0 / animation_speed)
		tween.tween_callback(screen_unlocked)
		StaticSfx.play_sfx(StaticSfx.success_sfx)

func screen_unlocked():
	self.visible = false


func _on_button_pressed():
	language_index = (language_index + 1) % 2
	$language_button.text = languages[language_index]
	StaticData.change_language(languages[language_index])


func _on_validate_pressed():
	_on_password_text_submitted("osef")
