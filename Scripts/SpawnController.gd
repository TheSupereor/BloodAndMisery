extends Node


onready var spawners = $Spawners.get_children()
onready var spawn_time = $SpawnTimer
onready var remaining_enemies_label = $CanvasLayer/RemainingEnemies

var enemy_count = [5, 10, 15]
var enemy_killed_round = 0
var remaining_enemies
var actual_round = -1
var remaining_enemies_spawn = enemy_count[actual_round]

signal change_round
signal enemy_killed


func spawn():
	if not (actual_round < 0 or actual_round > 2):
		var actual_spawner = randi() % len(spawners)
		if remaining_enemies_spawn > 0:
			spawners[actual_spawner].spawn()
			remaining_enemies_spawn -= 1


func enemy_killed():
	enemy_killed_round += 1
	remaining_enemies -= 1
	remaining_enemies_label.set_text(str(remaining_enemies))
	emit_signal("enemy_killed")
	if enemy_killed_round == enemy_count[actual_round]:
		emit_signal("change_round")


func round_changed():
	actual_round += 1
	remaining_enemies_spawn = enemy_count[actual_round]
	remaining_enemies = remaining_enemies_spawn
	remaining_enemies_label.set_text(str(remaining_enemies))
	enemy_killed_round = 0
