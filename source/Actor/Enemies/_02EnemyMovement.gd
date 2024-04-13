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
	#move_and_slide()
	follow(delta)
#------------------------------------------------------------------------------#
func _on_sight_body_entered(body):
	if body.name == "Player":
		player = body
		detected_player = true
func _on_sight_body_exited(body):
	if body.name == "Player":
		player = null
		detected_player = false
func follow(delta): 
	if player != null:
		look_at(player.position, Vector3.UP)
		var distance = player.position - position
		distance = distance.normalized()
		move_and_collide(distance * max_speed * delta)
