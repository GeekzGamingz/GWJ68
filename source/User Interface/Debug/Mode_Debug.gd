#Inherits Control Code
extends Control
#------------------------------------------------------------------------------#
@onready var pPOS_output = $VBoxContainer/GridContainer/PlayerPOSOutput
@onready var state_output = $VBoxContainer/GridContainer/StateOutput
@onready var pPoV_output = $VBoxContainer/GridContainer/PoVOutput
#------------------------------------------------------------------------------#
func _ready():
	visible = false
#------------------------------------------------------------------------------#
func _process(_delta: float):
	#State Output
	state_output.text = str(G.PLAYER.get_child(0).state_output.text)
	#Player Position Output
	var snapped_pPOS = G.PLAYER.position.snapped(Vector3.ONE * 0.01)
	pPOS_output.text = str(snapped_pPOS)
	#Point of View Output
	pPoV_output.text = str(G.PLAYER.camera_arm.PointOfView)
	#Toggle Visibility
	if Input.is_action_just_released("F3"):
		visible = !visible
