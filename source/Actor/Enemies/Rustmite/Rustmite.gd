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
	ragdoll()
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
		#Broken Sword
		"Broken_Slash": damage(5)
		"Broken_Chop": damage(10)
		"Broken_Thrust": damage(15)
		#Repaired Sword
		"Repaired_Slash": damage(15)
		"Repaired_Chop": damage(20)
		"Repaired_Thrust": damage(35)
		#Masterwork Sword
		"Masterwork_Slash": damage(25)
		"Masterwork_Chop": damage(30)
		"Masterwork_Thrust": damage(45)
		#Soulforged Sword
		"Soulforged_Slash": damage(35)
		"Soulforged_Chop": damage(40)
		"Soulforged_Thrust": damage(55)
