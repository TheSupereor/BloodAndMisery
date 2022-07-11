extends Area2D


export var damage : int = 20


func deal_damage(body):
	body.take_damage(damage)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
