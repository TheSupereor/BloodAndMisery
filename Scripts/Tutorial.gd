extends Node


func start_game():
	get_tree().change_scene("res://CenaTesteDungeon2.tscn")
	
	
func back_to_menu():
	get_tree().change_scene("res://Scenes/Main Scenes/Menu.tscn")
