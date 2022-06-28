class_name Enemy
extends KinematicBody2D


export var life: int = 100
export var speed : int = 200
export var damage : int = 20

var target = null
var direction = Vector2.ZERO
var current_hp

onready var attack_area = $AttackArea
onready var attack_timer = $AttackTimer

func ready():
	current_hp = life

func _physics_process(delta):
	if not target == null:
		direction = direction_8_ways()
		attack_area.position = (direction * 64)
		if not position.distance_to(target.position) < 100:
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


func leave_pursue(body: Node):
	target = null


func Initiate_Attack(body):
	if attack_timer.is_stopped():
		print("Ataquei")
		attack_timer.start()
	#target.take_damage(damage)


func _Initiate_Attack():
	if attack_timer.is_stopped():
		print("Ataquei")
		attack_timer.start()

func onHit(damage):
	current_hp -= damage
	get_node("HPBar").value = int((float(current_hp) / life) * 100)
	if current_hp <= 0:
		onDeath()
	pass
	
func onDeath():
	get_node("CollisionPoly").set_deferred("disabled", true)
	get_tree().quit()
