#Inherits StaticBody3D Code
extends StaticBody3D
#------------------------------------------------------------------------------#
#Constants
const COLLISION = preload("res://source/World/ProcGen/CollisionMap/CollisionMap.tscn")
#------------------------------------------------------------------------------#
#Variables
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
#Add Collisions
func _on_kinematics_child_entered_tree(node):
	if node.is_in_group("Kinematics") == true:
		var collision = COLLISION.instantiate()
		collision.position = node.position
		collision.entity = node
		add_child(collision)
