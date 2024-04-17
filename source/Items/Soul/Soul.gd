#Inherits RigidBody3D Code
extends RigidBody3D
class_name Soul
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var anim_player = $AnimationPlayer/AnimationPlayer
#------------------------------------------------------------------------------#
func _on_hitbox_soul_area_entered(area):
	if area.name == "Hitbox":
		G.set_soul_score(1)
		anim_player.play("explode")
		await anim_player.animation_finished
		queue_free()
