#Inherits Enemy Movement
extends EnemyMovement
#------------------------------------------------------------------------------#
#Variables
var elapsed_time: float = 0
var is_dead: bool = false
#Exported Variables
@export_flags_3d_physics var fragment_collision_layer: int = 1
@export_flags_3d_physics var fragment_collision_mask: int = 1
@export var shatter_speed: float = 4
@export var min_frag_lifetime: float = 1.2
@export var max_frag_lifetime: float = 1.0
#Onready Variables
@onready var mesh = $Mesh_Canopic
@onready var shatter_origin = $WorldDetectors/ShatterOrigin
@onready var sight = $WorldDetectors/Sight/CollisionShape3D
@onready var hitbox = $WorldDetectors/Hitbox/CollisionShape3D
@onready var atkbox = $Mesh_Canopic/Mesh/Skeleton3D/BoneAttachment3D/Atkbox_Light/CollisionShape3D
@onready var anim_player = mesh.get_node("AnimationPlayers/AnimationPlayer")
#------------------------------------------------------------------------------#
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Sword
		"Slash": damage(15)
		"Chop": damage(20)
		"Thrust": damage(25)
		"Soulblast": damage(35)
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
#Kill Switch
func kill():
	G.set_kill_score(1)
	mesh.set_deferred("visible", false) #Toggle Visibility
	hitbox.set_deferred("disabled", true) #Disable Old Collision
	atkbox.set_deferred("disabled", true) #Disable Attack
	sight.set_deferred("disabled", true) #Disable Sight
	is_dead = true #Death Flag
	shatter()
	loot()
	await get_tree().create_timer(3).timeout
	queue_free()
