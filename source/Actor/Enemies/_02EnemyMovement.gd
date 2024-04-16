#Inherits Actor Code
extends Actor
class_name EnemyMovement
#------------------------------------------------------------------------------#
#Variables
var player
var detected_player : bool = false
var swimming: bool = false
#OnReady Variables
@onready var facing = $WorldDetectors/Facing
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	enemy_bars = $ProgressBar/SubViewport/ProgressBars
#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(delta):
	#Add Gravity
	apply_gravity(delta)
	move_and_slide()
#------------------------------------------------------------------------------#
#Sight
func _on_sight_body_entered(body):
	if body.name == "Player":
		player = body
		detected_player = true
func _on_sight_body_exited(body):
	if body.name == "Player":
		player = null
		detected_player = false
#Movement
func follow(): 
	if player != null:
		look_at(player.position, Vector3.UP)
		var distance = ((player.global_position - global_position) * Vector3(1,0,1)).normalized()
		if !facing.is_colliding(): velocity = distance * max_speed
		else: velocity = Vector3.ZERO
func backaway():
	if player != null:
		look_at(player.position, Vector3.UP)
		var distance = (player.global_position - (global_position * Vector3.UP)).normalized()
		if !facing.is_colliding(): velocity = distance * max_speed
		else: velocity = Vector3.ZERO
