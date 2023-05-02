extends ColorRect

var shader


func _ready():
	shader = self.material
	get_window().size_changed.connect(size_changed)

func _process(delta):
	pass
	
func size_changed():
	shader.set_shader_parameter("resolution", get_window().size)

func _input(event):
	if event.is_action_pressed("ui_right", true):
		shader.set_shader_parameter("scanlines_width", shader.get_shader_parameter("scanlines_width") + 0.1)
	if event.is_action_pressed("ui_left", true):
		shader.set_shader_parameter("scanlines_width", shader.get_shader_parameter("scanlines_width") - 0.1)
	if event.is_action_pressed("ui_up", true):
		shader.set_shader_parameter("scanlines_opacity", shader.get_shader_parameter("scanlines_opacity") + 0.05)
	if event.is_action_pressed("ui_down", true):
		shader.set_shader_parameter("scanlines_opacity", shader.get_shader_parameter("scanlines_opacity") - 0.05)

