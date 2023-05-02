extends Control

var origin = Vector2()
var destination = Vector2()

func _ready():
	origin = self.position
	StaticSfx.play_sfx(StaticSfx.news_sfx, randf_range(0.9, 1.1))
	move_and_callback(destination)

func _process(delta):
	pass

func move_and_callback(destination, callback = null):
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "position", destination, 1.0)
	if callback:
		tween.tween_callback(callback)

func _on_texture_button_pressed():
	StaticSfx.play_sfx(StaticSfx.click31_sfx, 0.8)
	move_and_callback(origin, self.queue_free)
	$VBoxContainer/header/TextureButton.disabled = true




