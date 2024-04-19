#Inherits RigidBody3D Code
extends RigidBody3D
class_name Scrap
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#@onready var anim_player = $AnimationPlayer/AnimationPlayer
#------------------------------------------------------------------------------#
func _on_hitbox_scrap_area_entered(area):
	if area.name == "Hitbox_Player":
		G.set_scrap_score(1)
		queue_free()
