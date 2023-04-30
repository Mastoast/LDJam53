extends Button

var thread = {
		"sender" = "huissier",
		"receiver" = "Mairie",
		"messages" = [
			{"text": "Bonjour mairie comment ça va vous avez des sous",
			"type" : "sent"},
			{"text": "Non c'est la crise tchaoh",
			"type" : "received"}
		]
	}

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_pressed():
	get_tree().get_first_node_in_group("thread").fill_thread(thread)
