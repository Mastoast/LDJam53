extends Control
var threads = [
	{
		"sender" = "huissier",
		"receiver" = "Mairie",
		"messages" = [
			{"text": "Bonjour mairie comment ça va vous avez des sous ?",
			"type" : "sent"},
			{"text": "Non c'est la crise [mot]Mimi Mathy[/mot] tchaoh",
			"choices" : ["non", "non", "oui"],
			"type" : "received"}
		]
	}
]


func _ready():
	create_event(threads[0])


func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	$VBoxContainer/head/MarginContainer/HBoxContainer/time.text = current_time

func create_event(thread):
	$VBoxContainer/desktop/window_preview.create_com_event(thread)
	
	
