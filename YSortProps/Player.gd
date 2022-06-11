extends KinematicBody2D

var direction = Vector2()
var speed = 0
const MAX_SPEED = 15
const acceleration = 1000
var velocity = Vector2()
var anim_direction = 'S'

onready var _animated_sprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerAnimation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	playerMovement(delta)
	
	
func playerMovement(delta):
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	if direction == Vector2(0,0):
		speed = 0
	else:
		speed += acceleration * delta
		if speed > MAX_SPEED: 
			speed = MAX_SPEED
		velocity = direction.normalized() * speed
		move_and_collide(velocity)
	

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
