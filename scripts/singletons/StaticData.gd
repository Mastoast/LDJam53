extends Node

var threads = {}
var threads_file = "res://texts/threads.json"
var threads_file_fra = "res://texts/threads_fr.json"
var info_threads = {}
var info_threads_file = "res://texts/threads_info.json"
var info_threads_file_fra = "res://texts/threads_info_fr.json"

var is_tutorial_on = true
var language

func _ready():
	TranslationServer.set_locale("en")
	language = "ENG"

func _process(delta):
	pass

func change_language(language : String):
	if language == "ENG":
		TranslationServer.set_locale("en")
	elif language == "FRA":
		TranslationServer.set_locale("fr")
	self.language = language

func load_threads():
	if language == "ENG":
		threads = load_json_file(threads_file)
		info_threads = load_json_file(info_threads_file)
	elif language == "FRA":
		threads = load_json_file(threads_file_fra)
		info_threads = load_json_file(info_threads_file_fra)

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
