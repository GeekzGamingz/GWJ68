#Inherits RigidBody3D Code
extends RigidBody3D
class_name Fragment
#------------------------------------------------------------------------------#
#Variables
var elapsed_time: float = 0
#Exported Variables
@export var lifetime: float = 1
#------------------------------------------------------------------------------#
#Process Function
func _process(delta):
	elapsed_time += delta
	if elapsed_time > lifetime: queue_free()
#------------------------------------------------------------------------------#
#Create Fragment
func init_from_mesh(source: MeshInstance3D):
	global_transform = source.global_transform
	#Duplicate Fragment Mesh
	var mesh_instance: MeshInstance3D = source.duplicate()
	mesh_instance.transform = Transform3D.IDENTITY
	add_child(mesh_instance)
	#Create Convex Shape
	$CollisionShape3D.shape = source.mesh.create_convex_shape()
