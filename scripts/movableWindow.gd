extends Panel

var previous_mouse_position = Vector2()
var dragged = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if dragged:
			var mouse_delta = previous_mouse_position - get_local_mouse_position()
			position -= mouse_delta


func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragged = true
			previous_mouse_position = get_local_mouse_position()
		else:
			dragged = false
