extends Control
export(String) var scene_to_load

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_ResumeButton_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_BackToMenu_pressed():
	get_tree().change_scene(scene_to_load)
	get_tree().paused = false
	
