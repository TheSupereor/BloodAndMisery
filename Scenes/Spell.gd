extends RigidBody2D

var fire_direction
var skill_name
var projectile_speed = 200
var damage
var lifetime = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = int(DataImport.skill_data[skill_name].SkillDamage)
	projectile_speed = 200
	
	#var skill_texture = load("res//Assets/Skills/" + skill_name + ".png")
	#get_node("Sprite").set_texture(skill_texture)
	
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	selfDestruct()
	pass # Replace with function body.



func selfDestruct():
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()
#	pass


func _on_Spell_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	if body.is_in_group("Enemies"):
		body.onHit(damage)
	self.hide()
	pass # Replace with function body.
