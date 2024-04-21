#Inherits EnemyMovement Code
extends EnemyMovement
#------------------------------------------------------------------------------#
#Constants
const UI_BOSS_HP_BACKGROUND = preload("res://assets/Textures/UserInterface/ProgressBars/Enemies/UI_Boss_HPBackground.png")
const UI_BOSS_HP_OUTLINE = preload("res://assets/Textures/UserInterface/ProgressBars/Enemies/UI_Boss_HPOutline.png")
const UI_BOSS_HP_PROGRESS = preload("res://assets/Textures/UserInterface/ProgressBars/Enemies/UI_Boss_HP_Progress.png")

#Variables
var is_grappling: bool = false
#OnReady Variables
@onready var mesh = $Mesh_Queen
@onready var skeleton = $Mesh_Queen/ActorMesh/Skeleton3D
@onready var anim_player = mesh.get_node("AnimationPlayers/AnimationPlayer")
@onready var armL_player = mesh.get_node("AnimationPlayers/LeftArmPlayer")
@onready var armR_player = mesh.get_node("AnimationPlayers/RightArmPlayer")
@onready var clawR = mesh.get_node("ActorMesh/Skeleton3D/Claw_RAttachment")
#Health Textures
@onready var health_under = $ProgressBar/SubViewport/ProgressBars/Health/HealthUnder
@onready var health_over = $ProgressBar/SubViewport/ProgressBars/Health/HealthOver
#------------------------------------------------------------------------------#
func _ready():
	health_under.texture_under = UI_BOSS_HP_BACKGROUND
	health_under.texture_over = UI_BOSS_HP_OUTLINE
	health_under.texture_progress = UI_BOSS_HP_PROGRESS
	health_over.texture_over = UI_BOSS_HP_OUTLINE
	health_over.texture_progress = UI_BOSS_HP_PROGRESS
	
#Kill Switch
func kill():
	G.set_kill_score(1)
	G.set_boss_challenge(true)
	ragdoll()
	loot()
	await get_tree().create_timer(3).timeout
	queue_free()
#Shatter
func ragdoll():
	skeleton.physical_bones_start_simulation(['Skull'])
	skeleton.physical_bones_start_simulation(['Booty'])
	skeleton.physical_bones_start_simulation(['Leggie_FR_Claw'])
	skeleton.physical_bones_start_simulation(['Leggie_FL_Claw'])
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Sword
		"Slash": damage(1 + (float(G.sword_damage) / 2))
		"Chop": damage(3 + (float(G.sword_damage) / 2))
		"Thrust": damage(5 + (float(G.sword_damage) / 2))
		"Soulblast": damage(15 + (float(G.sword_damage) / 2))
#------------------------------------------------------------------------------#
