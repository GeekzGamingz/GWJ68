extends Node3D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var anim_player = $AnimationPlayers/AnimationPlayer
@onready var repaired = $Mesh_Swords/Repaired
@onready var masterwork = $Mesh_Swords/Masterwork
@onready var soulforged = $Mesh_Swords/Soulforged
#------------------------------------------------------------------------------#
func _ready():
	repaired.visible = false
	masterwork.visible = false
	soulforged.visible = false
