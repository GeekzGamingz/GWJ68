#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var state_output = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	state_add("idle")
	state_add("walk")
	state_add("run")
	state_add("fall")
	state_add("lookie")
	state_add("shoot")
	state_add("grab")
	state_add("slam")
	call_deferred("state_set", states.idle)
#------------------------------------------------------------------------------#
func _process(_delta: float):
	state_output.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
@warning_ignore("unused_parameter")
func state_logic(delta):
	match(state):
		states.lookie, states.grab, states.slam: 
			if !p.is_grappling: p.lookie()
	if p.is_grappling: G.PLAYER.global_position = p.clawR.global_position
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle, states.fall: return basic_move()
	#Lookie
		states.lookie:
			if !p.detected_player: return states.idle
			elif p.facing.is_colliding(): return states.grab
	#Grab
		states.grab: if !p.armR_player.is_playing(): return states.shoot
	#Shoot
		states.shoot: if !p.anim_player.is_playing(): return states.slam
	#Slam
		states.slam: if !p.armL_player.is_playing(): return states.idle
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle:
			p.anim_player.play("idle")
			p.armL_player.play("idle")
			p.armR_player.play("idle")
		states.shoot: p.anim_player.play("shoot")
		states.grab: p.armR_player.play("grab")
		states.slam: p.armL_player.play("slam")
	#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.lookie: p.velocity = Vector3.ZERO
		states.grab: p.armR_player.play("idle")
		states.slam: p.armL_player.play("idle")
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move():
	#Player Follow
	if p.detected_player: return states.lookie
	#Idle
	if p.velocity.x == 0 && p.check_grounded(): return states.idle
	#Verticle Movement
	if !p.check_grounded(): #When Airbourne
		if p.velocity.y > 0: return states.jump
		elif p.velocity.y < 0: return states.fall
	#Horizontal Movement
	elif p.velocity.x != 0 || p.velocity.z != 0:
		if p.max_speed == p.walk_speed: return states.walk
		elif p.max_speed == p.run_speed: return states.run
#Fly Movement
func fly_move(): pass
