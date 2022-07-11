extends Node


var game_scene = "res://CenaTesteDungeon2.tscn"
var actual_score

onready var actual_score_label = $CanvasLayer/CenterContainer/VBoxContainer/Label
onready var best_score_label = $CanvasLayer/CenterContainer/VBoxContainer/Label2
onready var button_audio_stream = $ButtonAudio


func _ready():
	show_score()


func close_game():
	get_tree().quit()


func restart_game():
	get_tree().change_scene(game_scene)


func show_score():
	var total_scores = load("res://Data/save_data.tres")
	var score_text = ""
	
	for i in total_scores.scores:
		score_text += str(i) + "\n"
	
	actual_score = Score.score
	actual_score_label.set_text(
			actual_score_label.get_text() + " " + str(actual_score))
	best_score_label.set_text(best_score_label.get_text() + " \n" + score_text)


func button_sound_start():
	button_audio_stream.play()
