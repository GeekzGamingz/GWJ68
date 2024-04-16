extends PlayerMovement
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#------------------------------------------------------------------------------#
func _on_hitbox_area_entered(area):
	match(area.name):
		#Generic Attacks
		"Atkbox_Light": damage(5)
		"Atkbox_Medium": damage(10)
		"Atkbox_Heavy": damage(15)
