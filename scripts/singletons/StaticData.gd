extends Node

var threads = {}
var threads_file = "res://texts/threads.json"


func _ready():
	threads = load_json_file(threads_file)


func load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		var dataFile  = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary or parsedResult is Array :
			return parsedResult
		else :
			print("parsing failed")
	else:
		print("File doesn't exists")
