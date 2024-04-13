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
	state_add("swim")
	state_add("fly")
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
		if p.swimming:
			p.position.y = G.sea_level
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
		states.swim: if p.check_grounded():
			if p.position.y >= G.sea_level: return swim_move()
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.strafe_l: p.max_speed = p.strafe_speed
		states.strafe_r: p.max_speed = p.strafe_speed
		states.backstep: p.max_speed = p.strafe_speed
		states.swim:
			p.swimming = !p.swimming
			p.raise_gDetectors()
	#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.swim:
			p.swimming = !p.swimming
			p.lower_gDetectors()
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move():
	#Swim
	if p.position.y < G.sea_level: return states.swim #When Below Sea Level
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
#Swimming Movement
func swim_move():
	if p.check_grounded(): return basic_move() #Expand Logic
#Fly Movement
func fly_move(): pass
