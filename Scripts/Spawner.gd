extends Node2D


var enemies = [
	preload("res://Scenes/Enemies/Enemy.tscn"),
	preload("res://Scenes/Enemies/EnemyBrown.tscn"),
	preload("res://Scenes/Enemies/EnemyBlue.tscn"),
	preload("res://Scenes/Enemies/EnemyRed.tscn")
]


func spawn():
	var enemy_spawn_list = randi() % len(enemies) + 1
	print(enemy_spawn_list)
	var packed_new_enemy = enemies[enemy_spawn_list]
	var new_enemy = packed_new_enemy.instance()
	new_enemy.set_position(position)
	get_tree().current_scene.add_child(new_enemy)
