extends Node


onready var button_audio = $ButtonAudio


func game_start():
	get_tree().change_scene("res://Scenes/Main Scenes/Tutorial.tscn")


func quit():
	get_tree().quit()


func button_up():
	button_audio.play()
