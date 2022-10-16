extends CSGBox
export(String) var scene_to_load

func _on_Area_body_entered(Player):
		get_tree().change_scene(scene_to_load)

func _ready():
	pass # Replace with function body.
