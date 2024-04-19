#Inherits Area3D Code
extends Area3D
#------------------------------------------------------------------------------#
#Variables
@export var player = CharacterBody3D
#Onready Variables
@onready var teleport_arm = $TeleportArm
@onready var teleport_pos = $TeleportArm/TeleportPOS
#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(_delta):
	if player != null:
		var distance = ((player.global_position - global_position) * Vector3(1,0,1)).normalized()
		teleport_arm.look_at(player.global_position + distance, Vector3.UP)
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
