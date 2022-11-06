extends Button

func _ready():
	pass 

# This funky bit of code here means that once the 'quit' button is pressed, it closes (quits) the application, shutting the game down.
func _on_Button_pressed():
	get_tree().quit()
