extends Node

var skill_data = {
	"melee": {
		"SkillType": "melee",
		"SkillDamage": 60,
		"SkillRadius": "N/A",
		"SkillDamageDelayTime": "N/A",
		"IRemoveDelayTime": "N/A"
	},
	"strMelee": {
		"SkillType": "melee",
		"SkillDamage": 100,
		"SkillRadius": "N/A",
		"SkillDamageDelayTime": "N/A",
		"IRemoveDelayTime": "N/A"
	},
	"AOE": {
		"SkillType": "AOE",
		"SkillDamage": 200,
		"SkillRadius": 90,
		"SkillDamageDelayTime": "0.2",
		"IRemoveDelayTime": 0.5
	}
}

#func _ready():
#	var skill_data_file = File.new()
#	skill_data_file.open("res://Data/SkillDatabase.json", File.READ)
#	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
#	skill_data_file.close()
#	skill_data = skill_data_json.result


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
