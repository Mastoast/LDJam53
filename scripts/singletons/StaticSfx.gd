extends Node

var error_sfx = load("res://audio/error.mp3")
var success_sfx = load("res://audio/success.mp3")
var click1_sfx = load("res://audio/click1.mp3")
var click2_sfx = load("res://audio/click2.mp3")
var click3_sfx = load("res://audio/click3.mp3")
var news_sfx = load("res://audio/news.mp3")

var audio_players = []


func _ready():
	pass

func _process(delta):
	for player in audio_players:
		if !player.playing:
			player.queue_free()
			audio_players.erase(player)

func play_sfx(stream, pitch = 1.0, position = 0.0):
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.pitch_scale = pitch
	get_tree().current_scene.add_child(player)
	player.play(position)
	audio_players.append(player)
