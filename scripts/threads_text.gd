extends Node

var threads = [
	{
		"sender" = "huissier",
		"receiver" = "Mairie",
		"messages" = [
			{"text": "Bonjour mairie comment ça va vous avez des sous ?",
			"type" : "sent"},
			{"text": ["Non c'est la crise", "tchaoh"],
			"choices" : ["Mimi Mathy", "non", "oui"],
			"type" : "received"}
		]
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
