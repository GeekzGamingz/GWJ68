#Inherits Area3D Code
extends Area3D
#------------------------------------------------------------------------------#
#Grapple Zone Entered
func _on_body_entered(body): if body.name == "Player":
	G.KINEMATICS.get_node("Rustmite_Queen").is_grappling = true
#Grapple Zone Left
func _on_body_exited(body): if body.name == "Player":
	G.KINEMATICS.get_node("Rustmite_Queen").is_grappling = false
