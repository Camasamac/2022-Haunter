extends KinematicBody

onready var nav = get_parent()
var path = []
var path_node = 0
var speed = 10
onready var player =$"../../Player"
# The double dot pattern that appears within this means that the enemy (while within the Navigation group) needs
# to look beyond that group (outside it by one level) and find the entity of the "player".

func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node +=1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	move_to(player.global_transform.origin)
	#this timer seems to be messing up my current enemy, as it stops the game after 2 seconds (the set time).

func _on_Area_body_entered(body):
	if (body.name == "Player"):
		Global.player_health-= 20
		print("Health: " + str(int(Global.player_health)))
		queue_free()

func take_damage(damage):
	print("ouch")
