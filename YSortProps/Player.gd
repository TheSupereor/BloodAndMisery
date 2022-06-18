extends KinematicBody2D


const MAX_SPEED = 450
const ACCELERATION = 1000

var direction = Vector2()
var speed = 0
var velocity = Vector2()
var anim_direction = 'S'
<<<<<<< Updated upstream
var health = 200
=======
<<<<<<< Updated upstream
var health = 200
=======
var can_attack = true
var attacking = false
>>>>>>> Stashed changes
>>>>>>> Stashed changes

onready var _animated_sprite = $AnimatedSprite
onready var life = $CanvasLayer/Life


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true) # Replace with function body.


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
	if direction == Vector2(0,0):
		speed = 0
	else:
		speed += ACCELERATION
		if speed > MAX_SPEED: 
			speed = MAX_SPEED
		velocity = direction.normalized() * speed
		move_and_slide(velocity)
<<<<<<< Updated upstream
=======
	
>>>>>>> Stashed changes
	
func skillLoop():
	if Input.is_action_pressed("skill_1") and can_attack == true:
		can_attack = false
		attacking = true
		var attack_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		match DataImport.skill_data(selected_skill).SkillType:
			

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
	

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
	life.set_value(health)
	
	
func die():
	get_tree().quit()
