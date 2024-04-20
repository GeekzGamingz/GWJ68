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
	state_add("walk_f")
	state_add("walk_b")
	state_add("walk_l")
	state_add("walk_r")
	state_add("run")
	state_add("strafe_l")
	state_add("strafe_r")
	state_add("backstep")
	state_add("jump")
	state_add("fall")
	state_add("fly")
	state_add("slash")
	state_add("chop")
	state_add("thrust")
	state_add("blast")
	call_deferred("state_set", states.idle)
#------------------------------------------------------------------------------#
func _process(_delta: float):
	state_output.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
@warning_ignore("unused_parameter")
func state_logic(delta):
	if p.controllable:
		p.apply_gravity(delta)
		p.handle_movement()
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle: return basic_move()
		states.walk_f, states.walk_b, states.walk_l, states.walk_r:
			return basic_move()
		states.run, states.strafe_l, states.strafe_r, states.backstep:
			return basic_move()
		states.fall: return basic_move()
		states.jump: return basic_move()
		states.slash: if !p.anim_player.is_playing():
			if Input.get_action_strength("action_attack") > 0:
				return states.chop
			return states.idle
		states.chop: if !p.anim_player.is_playing():
			if Input.get_action_strength("action_attack") > 0:
				return states.thrust
			return states.idle
		states.thrust: if !p.anim_player.is_playing():
			if Input.get_action_strength("action_attack") > 0:
				return states.slash
			return states.idle
		states.blast: if !p.anim_player.is_playing():
			p.deplete(10)
			return states.idle
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle: p.anim_player.play("idle")
		states.walk_f, states.walk_b, states.walk_l, states.walk_r:
			p.anim_player.play("float_f")
		states.strafe_l: p.max_speed = p.strafe_speed
		states.strafe_r: p.max_speed = p.strafe_speed
		states.backstep: p.max_speed = p.strafe_speed
		states.slash: p.anim_player.play("slash")
		states.chop: p.anim_player.play("chop")
		states.thrust: p.anim_player.play("thrust")
		states.blast: p.anim_player.play("soulblast")
	#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.idle: pass
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move():
	#Attack
	if Input.get_action_strength("action_attack") > 0: return states.slash
	if Input.get_action_strength("action_magic") > 0: if !p.out_of_soul: return states.blast
	#Idle
	if p.velocity.x == 0 && p.check_grounded(): return states.idle
	#Verticle Movement
	if !p.check_grounded(): #When Airbourne
		if p.velocity.y > 0: return states.jump
		elif p.velocity.y < 0: return states.fall
	#Horizontal Movement
	elif p.velocity.x != 0 || p.velocity.z != 0:
		if p.max_speed == p.walk_speed: #When Walking
			if Input.get_action_strength("move_forward") > 0: return states.walk_f
			elif Input.get_action_strength("move_back") > 0: return states.walk_b
			elif Input.get_action_strength("move_left") > 0: return states.walk_l
			elif Input.get_action_strength("move_right") > 0: return states.walk_r
		elif ((p.max_speed == p.run_speed) || #When Running
			(p.max_speed == p.strafe_speed)): #When Strafing
			if p.velocity.x || p.velocity.z != 0:
				if Input.get_action_strength("move_forward") == 0:
					if Input.get_action_strength("move_left") > 0: return states.strafe_l
					elif Input.get_action_strength("move_right") > 0: return states.strafe_r
					elif Input.get_action_strength("move_back") > 0: return states.backstep
				else: return states.run
#Fly Movement
func fly_move(): pass
