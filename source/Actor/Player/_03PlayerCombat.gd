extends PlayerMovement
#------------------------------------------------------------------------------#
#Signals
signal soul_heal(soul)
signal soul_damage(soul)
#Variables
var out_of_soul: bool = true
var is_dead: bool = false
#Exported Variables
@export var max_soul: float = 100
#OnReady Variables
@onready var soul = 0: set = set_soul
@onready var hitbox = $WorldDetectors/Hitbox_Player/CollisionShape3D
#------------------------------------------------------------------------------#
#Hitbox
func _on_hitbox_area_entered(area):
	match(area.name):
		#Generic Attacks
		"Atkbox_Light": damage(5)
		"Atkbox_Medium": damage(10)
		"Atkbox_Heavy": damage(15)
		#Souls
		"Hitbox_Soul": fill(10)
#Kill Switch
func kill(): is_dead = true
#------------------------------------------------------------------------------#
#Soul
#Fill
func fill(amount):
	set_soul(soul + amount)
	out_of_soul = false
	$PlayerUI/Controls/Nope2.visible = false
#Deplete
func deplete(amount):
	set_soul(soul - amount)
#Set Soul
func set_soul(value):
	var soul_prev = soul
	soul = clamp(value, 0, max_soul)
	if soul > soul_prev:
		emit_signal("soul_heal", soul)
		if soul == 100: pass
	if soul < soul_prev:
		emit_signal("soul_damage", soul)
		if soul == 0:
			out_of_soul = true
			$PlayerUI/Controls/Nope2.visible = true
