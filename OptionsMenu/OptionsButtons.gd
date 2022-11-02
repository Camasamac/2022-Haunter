extends Button

func _ready():
	pass # Replace with function body.

func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
