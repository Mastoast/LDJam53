extends PanelContainer

@export_color_no_alpha var line_color
@export var line_width = 10
var max_size_x = 300

var targets = []

func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	pass

func open(text : String):
	$VBoxContainer/MarginContainer/Label.visible_ratio = 0.0
	$VBoxContainer/MarginContainer/Label.text = text
	var tween = create_tween()
	tween.tween_property(self, "custom_minimum_size", Vector2(max_size_x, 0), 0.7).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($VBoxContainer/MarginContainer/Label, "visible_ratio", 1.0, 0.7)
	tween.tween_callback(create_lines)

func close():
	var tween = create_tween()
	tween.tween_property($VBoxContainer/MarginContainer/Label, "visible_ratio", 0, 0.7)
	tween.tween_property(self, "custom_minimum_size", get_minimum_size(), 0.7).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(queue_free)

func get_text():
	return $VBoxContainer/MarginContainer/Label.text

func create_lines():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.set_trans(Tween.TRANS_SINE)
	for target in targets:
		var line = Line2D.new()
		line.default_color = line_color
		line.width = line_width
		line.add_point(Vector2(position.x, position.y + size.y / 2))
		line.add_point(Vector2(position.x, position.y + size.y / 2))
		add_child(line)
