#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var state_output = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	state_add("idle_gem0")
	state_add("idle_gem1")
	state_add("idle_gem2")
	state_add("idle_gem3")
	state_add("strike")
	call_deferred("state_set", states.idle_gem0)
#------------------------------------------------------------------------------#
func _process(_delta: float):
	state_output.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
@warning_ignore("unused_parameter")
func state_logic(delta):
	match(state):
		states.idle_gem0: pass
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle_gem0: pass
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle_gem0: p.anim_player.play("idle_gem0")
		states.idle_gem1: p.anim_player.play("idle_gem1")
		states.idle_gem2: p.anim_player.play("idle_gem2")
		states.idle_gem3: p.anim_player.play("idle_gem3")
		states.strike: p.anim_player.play("strike")
	#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.idle_game0: pass
