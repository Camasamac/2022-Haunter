extends KinematicBody
export(String) var scene_to_load

var move_vec = Vector3()

#This loads in the Bullet3D file ands stores it onto a variable called "FIREBALL"
const FIREBALL = preload("res://Bullets/Bullet.tscn")
# This tells when you can shoot
var BulletReloadTimer = 0
# This is how many bullets you have shot
var BulletCount = 0

# Physics variables that will help for the player.
var movementSpeed = 10.0 # How fast the player can move.
var jumpStrength = 13.0 # How much force used to make player jump.
# ^ I thought of a gamemode of 'bunny mode' where there is a customised map for this mode with heigher ceilings and roofs (given that the jump strength is around 20-30). With this, likely jumpier enemies.
var gravity = 20 # Gravity's strength.

# cam look
var minCamVerticalAngle = -90.0		# Limit camera view to straight down.
var maxCamVerticalAngle = 90.0		# Limit camera view to straight up.
var lookSensitivity = 0.8			# How fast camera moves. 'mouse sensitivity'. 

# vectors
var playerVelocity : Vector3 = Vector3() 	# Players Velocity
var mouseDelta : Vector2 = Vector2()		# How much the mouse has moved since last frame refresh.

# player components
onready var camera = get_node("Camera")		# "attach" the camera to access from script.

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# called when an input is detected
func _input (event):
	# THIS BLOCK OF CODE MEANS THAT ONCE THE WINDOW IS CLICKED THE MOUSE IS CAPTURED AND IF YOU PRESS ESCAPE IT IS FREED.
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	if event.is_action_pressed("Shooting"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#Did the mouse move?
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			mouseDelta = event.relative

		
# called every frame
func _process (delta):
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minCamVerticalAngle, maxCamVerticalAngle)
  
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
  
	# reset the mouse delta vector
	mouseDelta = Vector2()

	$Camera/CurrentScoreNumberText.text = str(Global.Current_Score)
	$Camera/PlayerHealthNumberText.text = str(Global.player_health)
	if Global.player_health <= 0:
		print("You have died.")
		get_tree().change_scene("res://EndScenes/LoseScene.tscn")
		
	# When the timer runs out, the bullet will automatically reload.
	# This makes it so that you won't have too many bullets on screen at once.
	# This saves memory so that your game and computer won't slow down.
	BulletReloadTimer +=1
	if BulletReloadTimer >= 20:
		BulletReloadTimer = 0
		BulletCount = 0

func _unhandled_input(event):
# If the 'shooting' button aka the (left mouse) button is pressed and there are more than 3
# bullets, then fire and count the bullets until it gets to three
	if Input.is_action_just_pressed("Shooting") and BulletCount < 3:
		BulletCount+=1
		#Here we attach the Bullet3D File to the FIREBALL Variable constant.
		var Bullet = FIREBALL.instance()
		# After storing the whole FILE of the bullet3D, we can attach code for the Position3D that
		# was implemented to the player, so that the bullet can come FROM the player to begin with.
		
		# Dylan gave me the tip that if you connect the bullet spawn (in this case, position3D) to the
		# camera, you can shoot at any angle.
		Bullet.start($Camera/Position3D.global_transform)
		# Now we have to connect all of this to the player, so that they have control in this sequence.
		get_parent().add_child(Bullet)

# called every physics step
func _physics_process (delta):
	# reset the x and z velocity
	playerVelocity.x = 0
	playerVelocity.z = 0
	var input = Vector2()
	# movement inputs
	if Input.is_action_pressed("player_forward"):
		input.y -= 1
	if Input.is_action_pressed("player_backward"):
		input.y += 1
	if Input.is_action_pressed("player_left"):
		input.x -= 1
	if Input.is_action_pressed("player_right"):
		input.x += 1
	# normalize the input so we can't move faster diagonally
	input = input.normalized()
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	# set the velocity
	playerVelocity.z = (forward * input.y + right * input.x).z * movementSpeed
	playerVelocity.x = (forward * input.y + right * input.x).x * movementSpeed
	# apply gravity
	playerVelocity.y -= gravity * delta
#	print(playerVelocity.y)
	# move the player
	playerVelocity = move_and_slide(playerVelocity, Vector3.UP)
	# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		playerVelocity.y = jumpStrength
	
	# Very quickly in class, we implemented the power of sprinting while HOLDING down the shift key, where it
	# basically changes the speed in which the player runs when held.
	if Input.is_action_pressed("run"):
		movementSpeed = 30
	else:
		movementSpeed = 10

func _on_Area_area_entered(area):
	if area.name == "DoorPortal":
		print(area.name)
		get_tree().change_scene(scene_to_load)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
