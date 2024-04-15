#Inherits Enemy Movement
extends EnemyMovement
#------------------------------------------------------------------------------#
#Variables
var elapsed_time: float = 0
#Exported Variables
@export_flags_3d_physics var fragment_collision_layer: int = 1
@export_flags_3d_physics var fragment_collision_mask: int = 1
@export var shatter_speed: float = 4
@export var min_frag_lifetime: float = 1.2
@export var max_frag_lifetime: float = 1.0
#Onready Variables
@onready var mesh = $Mesh_Canopic
@onready var anim_player = mesh.get_node("AnimationPlayers/AnimationPlayer")
@onready var shatter_origin = $WorldDetectors/ShatterOrigin
#------------------------------------------------------------------------------#
#Kill Switch
func kill():
	$Mesh_Canopic.queue_free() #Remove Old Mesh
	$CollisionShape3D.set_deferred("disabled", true) #Disable Old Collision
	$WorldDetectors/Sight/CollisionShape3D.set_deferred("disabled", true) #Remove Sight
	shatter()
	await get_tree().create_timer(3).timeout
	queue_free()
#Shatter
func shatter(): 
	var p = get_parent()
	#Create Fragments
	for f in $Mesh_Fractured.get_children():
		if f is MeshInstance3D:
			var frag: Fragment = preload(
				"res://source/Actor/Enemies/Canopics/Fragment.tscn"
				).instantiate()
			frag.init_from_mesh(f)
			frag.collision_layer = fragment_collision_layer
			frag.collision_mask = fragment_collision_mask
			p.add_child(frag)
			#Caluclate Velocity
			var vel:Vector3 = (
				frag.global_transform.origin - shatter_origin.global_transform.origin
				) * shatter_speed
			frag.linear_velocity = vel
			#Calculate Lifetime
			frag.lifetime = randf_range(min_frag_lifetime, max_frag_lifetime)
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Broken Sword
		"Broken_Slash": damage(25)
		"Broken_Chop": damage(50)
		"Broken_Thrust": damage(75)
