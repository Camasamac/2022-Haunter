extends Button

export(String) var scene_to_load
func _ready():
	pass 

func _on_Button_pressed():
	get_tree().change_scene(scene_to_load)
