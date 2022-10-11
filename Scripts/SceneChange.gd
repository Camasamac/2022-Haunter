extends Button

export(String) var scene_to_load
func _ready():
	pass 

func _on_Button_pressed():
	get_tree().change_scene(scene_to_load)

func _on_StartButton_pressed():
	Global.player_health = 100
	Global.Current_Score = 0
# These are referred by Global instead of GlobalVariables because it is referenced as 'Global'
# in "Project" > "Project Settings" > "Autoload". Connected to global.gd.
