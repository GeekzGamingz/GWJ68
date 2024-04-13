#Inherits CharacterBody3D Code
extends CharacterBody3D
class_name Kinematics
#------------------------------------------------------------------------------#
#Variables
#Movement
#Sync's CharacterBody Gravity with RigidBody
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#Exported Variables
@export var walk_speed = 3.5
@export var run_speed = 7
var strafe_speed = (walk_speed + run_speed) / 2
var max_speed = walk_speed
#------------------------------------------------------------------------------#
func apply_gravity(delta):
	velocity.y -= gravity * delta
