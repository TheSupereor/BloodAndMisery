class_name Enemy
extends KinematicBody2D


export var life: int = 100
export var speed : int = 200
export var damage : int = 20

enum states {DEFAULT, PURSUE, ATTACKING, HITTING}

var target = null
var direction = Vector2.ZERO
var max_life
var state = states.DEFAULT

onready var attack_animation = $AnimationPlayer
onready var life_bar = $HPBar
onready var attack_area = $AttackArea
onready var attack_audio = $EnemyAttackAudio
onready var hit_audio = $EnemyHitAudio

signal enemy_killed


func _ready():
	var spawn_controller = get_tree().get_nodes_in_group("Controllers")[0]
	connect("enemy_killed", spawn_controller, "enemy_killed")
	max_life = life
	life_bar.max_value = max_life
	life_bar.value = life


func _physics_process(delta):
	if target == null:
		return
	direction = direction_8_ways()
	if state == states.DEFAULT or state == states.PURSUE:
		move_and_slide(direction * speed)


func direction_8_ways():
	var new_direction = position.direction_to(target.get_position())
	if new_direction.x < 0.5 and new_direction.x > -0.5:
		new_direction.x = 0
	elif new_direction.x >= 0.5:
		new_direction.x = 1
	elif new_direction.x <= -0.5:
		new_direction.x = -1
	if new_direction.y < 0.5 and new_direction.y > -0.5:
		new_direction.y = 0
	elif new_direction.y >= 0.5:
		new_direction.y = 1
	elif new_direction.y <= -0.5:
		new_direction.y = -1
	return new_direction


func pursue_player(body : Node):
	target = body
	state = states.PURSUE


func leave_pursue(body: Node):
	target = null
	state = states.DEFAULT


func initiate_attack(body):
	state = states.ATTACKING
	attack_area.position = direction * 64
	attack_audio.play()
	attack_animation.play("Attack")


func leave_attack_range(body):
	state = states.PURSUE
	

func deal_damage(body):
	body.take_damage(damage)


func take_damage(damage):
	life -= damage
	life_bar.value = life
	hit_audio.play()
	if life <= 0:
		die()


func die():
	emit_signal("enemy_killed")	
	queue_free()


func attack_finished(anim_name):
	attack_area.position = Vector2.ZERO
	if state == states.ATTACKING:
		initiate_attack(target)
