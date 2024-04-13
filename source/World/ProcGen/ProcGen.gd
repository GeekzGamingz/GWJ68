#Inherits StaticBody3D Code
extends StaticBody3D
#------------------------------------------------------------------------------#
#Variables
#Preloaded Variables
const COLLISION = preload("res://source/World/ProcGen/CollisionMap/CollisionMap.tscn")
#Exported Variables
@export var player = CharacterBody3D
#OnReady Variables
@onready var kinematics = G.KINEMATICS
#------------------------------------------------------------------------------#
#Ready
func _ready():
	#Distribute Collisions
	for kinematic in kinematics.get_children():
		var collision = COLLISION.instantiate()
		collision.position = kinematic.position
		collision.entity = kinematic
		add_child(collision)
