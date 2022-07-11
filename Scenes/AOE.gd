extends Area2D


var skill_name
var damage
var damage_delay = 0.1
var remove_delay_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = int(DataImport.skill_data[skill_name].SkillDamage)
	damage_delay = float(DataImport.skill_data[skill_name].SkillDamageDelayTime)
	remove_delay_time = float(DataImport.skill_data[skill_name].IRemoveDelayTime)
	get_node("CollisionShape2D").get_shape().radius = DataImport.skill_data[skill_name].SkillRadius
	
	AOEAttack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func AOEAttack():
	# animação
	# get_node("Sprite")
	yield(get_tree().create_timer(damage_delay), "timeout")
	var targets = get_overlapping_bodies()
	for target in targets:
		target.take_damage(damage)
	yield(get_tree().create_timer(remove_delay_time), "timeout")
	self.queue_free()
