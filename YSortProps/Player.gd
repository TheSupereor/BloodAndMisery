extends KinematicBody2D

var direction = Vector2()
var speed = 0
const MAX_SPEED = 400
var velocity = Vector2()
var look_to = ''

onready var _animated_sprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	direction = Vector2()

	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		_animated_sprite.play("RunOeste")
		look_to = "Oeste"
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
		_animated_sprite.play("RunE")
		look_to = "Leste"
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
			_animated_sprite.play("RunNE")
			look_to = "Nordeste"

	elif Input.is_action_pressed("ui_up"):
		direction.y = -1
		_animated_sprite.play("RunNorte")
		look_to = "Norte"		
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
		_animated_sprite.play("RunS")
		look_to = "Sul"	

	if direction != Vector2():
		speed = MAX_SPEED
	else:
		speed = 0
		match look_to:
			"Oeste":
				_animated_sprite.play("IdleOeste")
			"Leste":
				_animated_sprite.play("IdleE")
			"Norte":
				_animated_sprite.play("IdleNorte")
			"Sul":
				_animated_sprite.play("IdleS")
			"Nordeste":
				_animated_sprite.play("IdleNE")

	velocity = speed * direction.normalized() * delta

	move_and_collide(velocity)
