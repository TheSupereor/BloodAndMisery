extends Area2D


var damage


func _init(damage):
	self.damage = damage

func deal_damage(body):
	body.take_damage(damage)
