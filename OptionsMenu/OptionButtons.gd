extends VBoxContainer
# The reason why this script affects the VBoxContainer instead of the buttons directly is because
# the VBoxContainer needs to be able to identify the buttons when calling their respective actions.
# For instance, the $SonicSpeedButton.pressed script says that the VBoxContainer needs to look for
# a button called SonicSpeedButton and call that action.

# If you link that code to the buttons, then they will try looking inside themselves looking for
# themselves, and eventually break the game.

func _ready():
	$SonicSpeedButton.pressed = Global.sonic_speed
	#$VBoxContainer/SonicSpeedButton.pressed = 
	print("bing")

# When the fullscreen button is pressed, the code says to 'cancel' the current resolution of the game (windowed).
# The opposite version of the current resolution (windowed) is fullscreen borderless.
func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

# This code means that when the SonicSpeedButton is pressed, it will stay pressed even when you exit the menu.
# Warning: It will automatically reset if you exit the game.
func _on_SonicSpeedButton_toggled(button_pressed):
	Global.sonic_speed = button_pressed
