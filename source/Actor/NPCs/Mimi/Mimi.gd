#Inherits EnemyMovement Code
extends EnemyMovement
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var mesh = $Mesh_Mimi
@onready var skeleton = $Mesh_Mimi/Mesh_Mimi/Skeleton3D
@onready var anim_player = mesh.get_node("AnimationPlayers/AnimationPlayer")
@onready var dialogue = $ProgressBar/SubViewport/Dialogue
#------------------------------------------------------------------------------#
#Kill Switch
func kill():
	loot()
	await get_tree().create_timer(3).timeout
	queue_free()
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	dialogue.no_chat()
#------------------------------------------------------------------------------#
#Areas
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Sword
		"Slash": pass #Unimpressed Treasure Chest Noises
		"Chop": pass #Unimpressed Treasure Chest Noises
		"Thrust": pass #Unimpressed Treasure Chest Noises
		"Soulblast": pass #Happy Treasure Chest Noises
#------------------------------------------------------------------------------#
#Challenges
#Beckon Entered
func _on_beckon_area_entered(area):
	dialogue.beckon()
#Beckon Exited
func _on_beckon_area_exited(area):
	dialogue.no_chat()
#Challenge Entered
func _on_challenge_area_entered(area):
	dialogue.challenge()
#Challenge Exited
func _on_challenge_area_exited(area):
	dialogue.beckon()
