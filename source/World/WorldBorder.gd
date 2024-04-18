#Inherits Area3D Code
extends Area3D
#------------------------------------------------------------------------------#
#Variables
#Onready Variables
#------------------------------------------------------------------------------#
#Area Enter
func _on_area_entered(area):
	match(area.name):
		"Hitbox_Player": pass
#Area Leaving
func _on_area_exited(area):
	match(area.name):
		"Hitbox_Player": pass
#Area Teleport
func _on_warning_zone_exited(area):
	match(area.name):
		"Hitbox_Player": G.PLAYER.global_position = G.SPAWN.global_position
