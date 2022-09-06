extends Spatial

func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	if (body.name == "Player"):
		print("collided")
		Global.Current_Score += 1
		print(Global.Current_Score)
		queue_free()
	#Prints collided, adds 1 to the score, and then removes the object from the current scene.

func _process(delta):
	rotate_y(deg2rad(180*delta))
