extends Node2D


onready var detection_area = $Area2D

var enemies = [
	preload("res://Scenes/Enemies/EnemyBrown.tscn"),
	preload("res://Scenes/Enemies/EnemyBlue.tscn"),
	preload("res://Scenes/Enemies/EnemyRed.tscn")
]

var spawn = false
var is_enemy_detected = false
var new_enemy_position = position


func _physics_process(delta):
	if spawn:
		if not is_enemy_detected:
			var enemy_spawn_list = randi() % len(enemies)
			var packed_new_enemy = enemies[enemy_spawn_list]
			var new_enemy = packed_new_enemy.instance()
			new_enemy.set_position(new_enemy_position)
			get_tree().get_nodes_in_group("y_sort")[0].add_child(new_enemy)
			spawn = false
			new_enemy_position = position
#		elif is_enemy_detected:
#			new_enemy_position.x += 64
#			detection_area.position = new_enemy_position

func spawn():
	spawn = true


func enemy_detected(body):
	is_enemy_detected = true


func enemy_not_detected(body):
	is_enemy_detected = false
