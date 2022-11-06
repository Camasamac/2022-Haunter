extends VBoxContainer

func _process (delta):
	$CurrentScore.text = str(Global.Current_Score)
	$EnemiesKilled.text = str(Global.enemies_killed)
	
func _ready():
	pass # Replace with function body.
