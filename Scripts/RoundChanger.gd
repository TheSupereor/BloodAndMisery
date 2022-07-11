extends Node


var actual_round = 0

onready var timer = $Timer
onready var timer_countdown = $TimerCountDown
onready var time_countdown = $CanvasLayer/TimeCountdown
onready var remove_text_timer = $RemoveTextTimer
onready var game_complete_audio = get_parent().get_node("Audios/RoundCompleteAudio")
onready var round_changing_audio = get_parent().get_node("Audios/RoundChanging")

signal initialize_round
signal game_finished


func _ready():
	time_countdown.set_visible(true)
	timer_countdown.start()
	timer.start()
	time_countdown.set_text("5")


func change_round():
	game_complete_audio.play()


func initialize_round():
	timer_countdown.stop()
	remove_text_timer.start()
	emit_signal("initialize_round")


func change_time_text():
	var time_text = int(time_countdown.get_text())
	time_text -= 1
	if time_text > 0:
		time_countdown.set_text(str(time_text))
	elif time_text <= 0:
		time_countdown.set_text("Vai")


func remove_text():
	time_countdown.set_visible(false)
	

func player_died():
	emit_signal("game_finished")
	get_tree().change_scene("res://Scenes/Main Scenes/EndGame.tscn")
	
	
func round_change_audio_finished():
	actual_round += 1
	if actual_round < 3:
		round_changing_audio.play()
		time_countdown.set_visible(true)
		timer_countdown.start()
		timer.start()
		time_countdown.set_text("5")
	elif actual_round >= 3:
		emit_signal("game_finished")
		get_tree().change_scene("res://Scenes/Main Scenes/EndGame.tscn")
