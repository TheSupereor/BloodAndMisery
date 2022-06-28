extends KinematicBody2D

const MAX_SPEED = 450
const ACCELERATION = 1000

var direction = Vector2()
var speed = 0
var velocity = Vector2()
var anim_direction = 'S'

var health = 200

var selected_skill
var can_attack = true
var attacking = false
var rate_of_fire = 0.7
var fire_direction

var melee = false
var damage

onready var _animated_sprite = $AnimatedSprite
onready var life = $CanvasLayer/Life


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true) # Replace with function body.


# warning-ignore:unused_argument
func _input(event):
	if Input.is_key_pressed(KEY_E):
		take_damage(30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerAnimation()
	skillLoop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	playerMovement(delta)
	
	
func playerMovement(delta):
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	if direction == Vector2(0,0) and (attacking == false or melee == false):
		speed = 0
	else:
		speed += ACCELERATION
		if speed > MAX_SPEED: 
			speed = MAX_SPEED
		velocity = direction.normalized() * speed
		move_and_slide(velocity)
	
	
func skillLoop():
	
	if Input.is_action_pressed("skill_1") and can_attack == true:
		ability("melee")
	elif Input.is_action_pressed("skill_2") and can_attack == true:
		ability("strMelee") 
	elif Input.is_action_pressed("skill_3") and can_attack == true:
		ability("AOE")
	

func playerAnimation():
	var anim_mode = 'Idle'
	var animation
	
	match direction:
		Vector2(-1,0):
			anim_direction = 'W'
		Vector2(1,0):
			anim_direction = 'E'
		Vector2(0,-0.5):
			anim_direction = 'N'
		Vector2(0,0.5):
			anim_direction = 'S'
		
		Vector2(-1,-0.5):
			anim_direction = 'NW'
		Vector2(-1,0.5):
			anim_direction = 'SW'
		Vector2(1,-0.5):
			anim_direction = 'NE'
		Vector2(1,0.5):
			anim_direction = 'SE'
			
	if direction != Vector2(0,0):
		anim_mode = 'Run'
	else:
		anim_mode = 'Idle'
	animation = anim_mode + anim_direction
	_animated_sprite.play(animation)
	

func ability(ability_name):
	can_attack = false
	attacking = true
	speed = 0
	
	fire_direction = get_angle_to(get_global_mouse_position())
	
	match DataImport.skill_data[ability_name].SkillType:
		"melee":
			melee = true
			damage = DataImport.skill_data[ability_name].SkillDamage
			
			#var skill = load("res://Scenes/Spell.tscn")
			#var spell_instance = skill.instance()
			#spell_instance.skill_name = ability_name
			# instanciando a spell
			#var attack_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
			#spell_instance.position = get_global_position()
			#spell_instance.rotation = fire_direction
	
			#get_parent().add_child(spell_instance)
			pass
			
		"AOE":
			var skill = load("res://Scenes/AOE.tscn")			
			var spell_instance = skill.instance()
			spell_instance.skill_name = ability_name
			spell_instance.position = get_global_position()
			
			get_parent().add_child(spell_instance)
	
	
	
	yield(get_tree().create_timer(rate_of_fire), "timeout")
	can_attack = true
	attacking = false
	melee = false
	
	#match DataImport.skill_data[selected_skill].SkillType:

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
	life.set_value(health)
	
	
func die():
	get_tree().quit()


func _on_meleeRange_body_entered(body):
	if body.is_in_group("Enemies"):
		if ((get_angle_to( get_global_mouse_position()) /3.14 ) * 180) <= (fire_direction + 25) and ((get_angle_to( get_global_mouse_position()) /3.14 ) * 180) >= (fire_direction - 25):
			body.onHit(damage)
			print("ataquei inimigo " + body)
	pass # Replace with function body.
