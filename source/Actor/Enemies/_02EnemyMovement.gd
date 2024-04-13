#Inherits Actor Code
extends Actor
#------------------------------------------------------------------------------#
#Variables
var player
var detected_player : bool = false
#------------------------------------------------------------------------------#
func _physics_process(delta):
	#Add Gravity
	apply_gravity(delta)
	move_and_slide()
	follow()
#------------------------------------------------------------------------------#
func _on_sight_body_entered(body):
	if body.name == "Player":
		player = body
		detected_player = true
func _on_sight_body_exited(body):
	if body.name == "Player":
		player = null
		detected_player = false
func follow(): 
	if player != null:
		look_at(player.position, Vector3.UP)
		var distance = (player.global_position - global_position).normalized()
		if !$Facing.is_colliding(): velocity = distance * max_speed
		else: velocity = Vector3.ZERO
