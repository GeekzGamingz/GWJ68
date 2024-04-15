extends PlayerMovement
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#------------------------------------------------------------------------------#
#Ready
func _ready():
	G.UI.get_node("Mode_UI/ProgressBars").connect("health_heal", heal)
	G.UI.get_node("Mode_UI/ProgressBars").connect("health_damage", damage)
	#G.UI.get_node("ProgressBars").connect("soul_heal", heal)
	#G.UI.get_node("ProgressBars").connect("soul_damage", heal)

func _on_hitbox_area_entered(area):
	match(area.name):
		#Generic Attacks
		"Atkbox_Light": damage(5)
		"Atkbox_Medium": damage(10)
		"Atkbox_Heavy": damage(15)
