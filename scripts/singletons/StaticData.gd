extends Node

var threads = {}
var threads_file = "res://texts/threads.json"
var threads_file_fra = "res://texts/threads_fr.json"
var info_threads = {}
var info_threads_file = "res://texts/threads_info.json"
var info_threads_file_fra = "res://texts/threads_info_fr.json"

var language

var error_sfx = load("res://audio/error.mp3")
var success_sfx = load("res://audio/success.mp3")
var click1_sfx = load("res://audio/click1.mp3")
var click2_sfx = load("res://audio/click2.mp3")
var click3_sfx = load("res://audio/click3.mp3")
var news_sfx = load("res://audio/news.mp3")

var players = []

func _ready():
	language = "ENG"
	print(get_tree())
	print(get_tree().current_scene)

func _process(delta):
	for player in players:
		if !player.playing:
			player.queue_free()

func play_sfx(stream, pitch = 1.0, position = 0.0):
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.pitch_scale = pitch
	get_tree().current_scene.add_child(player)
	player.play(position)

func load_language():
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
