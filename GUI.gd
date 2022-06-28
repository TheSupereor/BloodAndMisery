extends CanvasLayer

onready var shortcuts_path = "Skillbar/Background/HBoxContainer/"

var loaded_skills = {
	"Skill1": "melee",
	"Skill2": "strMelee",
	"Skill3": "AOE"
	}

func _ready():
	LoadShortcuts()
	for shortcut in get_tree().get_nodes_in_group("Shortcuts"):
		shortcut.connect("pressed", self, "SelectShortcut", [shortcut.get_parent().get_name()])


func LoadShortcuts():
	for shortcut in loaded_skills.keys():
		var skill_icon = load("res://Assets/_Skills/" + loaded_skills[shortcut]+ "_icon.png")
		get_node(shortcuts_path + shortcut + "/TextureButton").set_normal_texture(skill_icon)

func selectShortcut(shortcut):
	get_parent().get_node("YSort/Player").selected_skill = loaded_skills[shortcut]
	
