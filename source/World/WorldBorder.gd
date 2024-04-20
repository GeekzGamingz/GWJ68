#Inherits Area3D Code
extends Area3D
#------------------------------------------------------------------------------#
#Variables
var warning: bool = false
#Exported Variables
@export var player = CharacterBody3D
#Onready Variables
@onready var teleport_arm = $TeleportArm
@onready var teleport_pos = $TeleportArm/TeleportPOS
@onready var duty_bound = G.UI.get_node("DutyBound")

#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(_delta):
	if player != null:
		var distance = ((player.global_position - global_position) * Vector3(1,0,1)).normalized()
		teleport_arm.look_at(player.global_position + distance, Vector3.UP)
	duty_bound.visible = warning
#Area Teleport
func _on_area_exited(area):
	match(area.name):
		"Hitbox_Player": 
			G.PLAYER.global_position = G.SPAWN_BORDER.global_position
			warning = false
#Warning Zone Enter (Exiting World)
func _on_warning_zone_entered(area):
	match(area.name):
		"Hitbox_Player":
			warning = false
#Warning Zone Leaving (Entering World)
func _on_warning_zone_exited(area):
	match(area.name):
		"Hitbox_Player":
			warning = true
			await get_tree().create_timer(3).timeout
			warning = false
