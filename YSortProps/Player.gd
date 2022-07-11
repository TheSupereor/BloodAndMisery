extends KinematicBody2D

const MAX_SPEED = 450
const ACCELERATION = 30

var direction = Vector2()
var speed = 0
var velocity = Vector2()
var anim_direction = 'S'

var health = 200

var can_attack = true
var is_diyng = false
var aoe_can_attack = true

onready var _animated_sprite = $AnimatedSprite
onready var life = $CanvasLayer/Life
onready var melee_range = $meleeRange
onready var melee_animation = $AnimationPlayer
onready var rate_of_fire_timer = $Timers/RateOfFire
onready var attack_audio_stream = $AttackAudio
onready var hit_audio_stream = $HitAudio
onready var die_audio_stream = $DieAudio
onready var aoe_countdown = $Timers/AOETimer
onready var aoe_hud = $CanvasLayer/AOEHud

var skill = preload("res://Scenes/AOE.tscn")
var melee_attack = preload("res://Scenes/Player/MeleeAttack.tscn")
var str_attack = preload("res://Scenes/Player/StrongAttack.tscn")

signal player_dead


func _input(event):
	skillLoop(event)


func _process(delta):
	playerAnimation()


func _physics_process(delta):
	playerMovement(delta)
	
	
func playerMovement(delta):
	if not can_attack:
		return
		
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	if direction == Vector2.ZERO or not can_attack or is_diyng:
		speed = 0
	else:
		if speed > MAX_SPEED: 
			speed = MAX_SPEED
		elif speed < MAX_SPEED:
			speed += ACCELERATION
		move_and_slide(direction.normalized() * speed)
	
	
func skillLoop(event):
	if event.is_action_pressed("skill_1") and can_attack:
		ability("melee")
	elif event.is_action_pressed("skill_2") and can_attack:
		ability("strMelee") 
	elif event.is_action_pressed("skill_3") and can_attack:
		ability("AOE")
	

func playerAnimation():
	var anim_mode = 'Idle'
	if is_diyng:
		return
	
	match direction:
		Vector2(-1,0):
			anim_direction = 'W'
			melee_range.position = Vector2(-90,0)
		Vector2(1,0):
			anim_direction = 'E'
			melee_range.position = Vector2(90,0)
		Vector2(0,-0.5):
			anim_direction = 'N'
			melee_range.position = Vector2(0,-90)
		Vector2(0,0.5):
			anim_direction = 'S'
			melee_range.position = Vector2(0,90)
		
		Vector2(-1,-0.5):
			anim_direction = 'NW'
			melee_range.position = Vector2(-45,-45)
		Vector2(-1,0.5):
			anim_direction = 'SW'
			melee_range.position = Vector2(-45,45)
		Vector2(1,-0.5):
			anim_direction = 'NE'
			melee_range.position = Vector2(45,-45)
		Vector2(1,0.5):
			anim_direction = 'SE'
			melee_range.position = Vector2(45,45)
	
	if not can_attack:
		_animated_sprite.play('Idle' + anim_direction)
		return
	elif direction != Vector2.ZERO:
		anim_mode = 'Run'
	else:
		anim_mode = 'Idle'
	var animation = anim_mode + anim_direction
	
	if not can_attack:
		melee_animation.play("Attack")
		
	_animated_sprite.play(animation)
	

func ability(ability_name):
	can_attack = false
	var ability = DataImport.skill_data[ability_name]
	
	match ability_name:
		"melee":
			var new_attack = melee_attack.instance()
			new_attack.position = melee_range.position
			add_child(new_attack)
			rate_of_fire_timer.set_wait_time(0.4)
		"strMelee":
			var new_attack = str_attack.instance()
			new_attack.position = melee_range.position
			add_child(new_attack)
			rate_of_fire_timer.set_wait_time(1)
		"AOE":
			if not aoe_can_attack:
				can_attack = true
				return
				
			var spell_instance = skill.instance()
			spell_instance.skill_name = ability_name
			spell_instance.position = melee_range.position
			add_child(spell_instance)
			aoe_can_attack = false
			aoe_countdown.start()
			aoe_hud.set_frame_color(Color(0, 0, 0, 1))
			rate_of_fire_timer.set_wait_time(1)
	
	attack_audio_stream.play()
	rate_of_fire_timer.start()
	#match DataImport.skill_data[selected_skill].SkillType:
	

func rate_of_fire_timeout():
	can_attack = true
	

func take_damage(damage):
	health -= damage
	hit_audio_stream.play()
	if health <= 0:
		is_diyng = true
		melee_animation.play("DieAnimation")
		die_audio_stream.play()
	life.set_value(health)


func die_animation_finished():
	print("Oi")
	emit_signal("player_dead")
	
	
func aoe_recharged():
	aoe_can_attack = true
	aoe_hud.set_frame_color(Color(1, 1, 1, 1))
