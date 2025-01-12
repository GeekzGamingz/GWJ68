#Inherits EnemyMovement Code
extends EnemyMovement
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var mesh = $Mesh_Rustmite
@onready var skeleton = $Mesh_Rustmite/ActorMesh/Skeleton3D
@onready var anim_player = mesh.get_node("AnimationPlayers/AnimationPlayer")
#------------------------------------------------------------------------------#
#Kill Switch
func kill():
	G.set_kill_score(1)
	ragdoll()
	loot()
	await get_tree().create_timer(3).timeout
	queue_free()
#Shatter
func ragdoll():
	skeleton.get_node("Physical Bone Torso/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Skull/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Booty/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Leggie_FL/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Leggie_FR/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Leggie_RL/CollisionShape3D").set_deferred("disabled", false)
	skeleton.get_node("Physical Bone Leggie_RR/CollisionShape3D").set_deferred("disabled", false)
	skeleton.physical_bones_start_simulation()
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Sword
		"Slash": damage(5 + G.sword_damage)
		"Chop": damage(10 + G.sword_damage)
		"Thrust": damage(15 + G.sword_damage)
		"Soulblast": damage(35 + G.sword_damage)
