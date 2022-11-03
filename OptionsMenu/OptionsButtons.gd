extends Button

func _ready():
	self.pressed = Global.sonic_speed
	#$VBoxContainer/SonicSpeedButton.pressed = 
	print("bing")

func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_SonicSpeedButton_toggled(button_pressed):
	Global.sonic_speed = button_pressed
