#Inherits RigidBody3D Code
extends RigidBody3D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var anim_player = $AnimationPlayer/AnimationPlayer
#------------------------------------------------------------------------------#
func _on_hitbox_soul_area_entered(area):
	if area.name == "Hitbox":
		anim_player.play("explode")
		await anim_player.animation_finished
		queue_free()
