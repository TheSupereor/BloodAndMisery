extends Node


onready var spawners = $Spawners.get_children()
onready var spawn_time = $SpawnTimer
onready var enemy_remaining_label = $CanvasLayer/Label

var enemy_count = [
	5,
	10,
	15
]

var actual_round = 0
var remaining_enemies = enemy_count[actual_round]


func change_round():
	actual_round += 1
	remaining_enemies = enemy_count[actual_round]


func spawn():
	var actual_spawner = randi() % len(spawners)
	if remaining_enemies > 0:
		spawners[actual_spawner].spawn()
		remaining_enemies -= 1
		enemy_remaining_label.set_text(str(remaining_enemies))
