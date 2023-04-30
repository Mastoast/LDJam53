extends Control
var threads = [
	{
		"sender" = "huissier",
		"receiver" = "Mairie",
		"messages" = [
			{"text": "Bonjour mairie comment ça va vous avez des sous",
			"type" : "sent"},
			{"text": "Non c'est la crise tchaoh",
			"type" : "received"}
		]
	}
]


func _ready():
	var thread = threads[0]
	create_event(thread.sender, thread.receiver, thread.messages)


func _process(delta):
	var current_time = Time.get_time_string_from_system().substr(0, 5)
	$VBoxContainer/head/MarginContainer/HBoxContainer/time.text = current_time

func create_event(sender, receiver, messages):
	$VBoxContainer/desktop/events_window.create_com_event(sender, receiver, messages)
	
	
