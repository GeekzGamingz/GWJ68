#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var state_output = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	state_add("idle_closed")
	state_add("idle_opened")
	state_add("challenge1")
	state_add("challenge2")
	state_add("challenge3")
	state_add("challenge_boss")
	call_deferred("state_set", states.idle_closed)
#------------------------------------------------------------------------------#
func _process(_delta: float):
	state_output.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
@warning_ignore("unused_parameter")
func state_logic(delta):
	match(state):
		states.idle_closed: pass
		states.idle_opened: p.lookie()
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle_closed: if p.detected_player: return states.idle_opened
		states.idle_opened: if !p.detected_player: return states.idle_closed
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle_closed: p.anim_player.play("idle_closed")
		states.idle_opened: p.anim_player.play("idle_open")
	#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.idle_closed: pass
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move(): pass
#Fly Movement
func fly_move(): pass
