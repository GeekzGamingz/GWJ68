#Inherits Marker3D Code
extends Marker3D
#------------------------------------------------------------------------------#
#Constants
const CANOPIC = preload("res://source/Actor/Enemies/Canopics/Canopic.tscn")
const RUSTMITE = preload("res://source/Actor/Enemies/Rustmite/Rustmite.tscn")
const SOUL = preload("res://source/Items/Soul/Soul.tscn")
const SCRAP = preload("res://source/Items/Scrap/Scrap.tscn")
#Variables
var kinematic_present: bool = false
#Exported Variables
@export_enum("Canopic", "Rustmite", "Soul", "Scrap") var entity: String
#OnReady Variables
@onready var spawn_timer = $SpawnTimer
#------------------------------------------------------------------------------#
#Attempt Spawn
func _on_spawn_timer_timeout(): 
	if kinematic_present == false:
		var entity_scene
		match(entity):
			"Canopic": entity_scene = CANOPIC.instantiate()
			"Rustmite": entity_scene = RUSTMITE.instantiate()
			"Soul": entity_scene = SOUL.instantiate()
			"Scrap": entity_scene = SCRAP.instantiate()
		entity_scene.global_transform = global_transform
		G.KINEMATICS.add_child(entity_scene)
#Entering Bodies
func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		if body.is_in_group("Jar") == false: kinematic_present = true
	spawn_timer.stop()
#Exiting Bodies
func _on_area_3d_body_exited(body):
	if body.name == "Player":
		kinematic_present = false
		spawn_timer.start()
