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
	state_add("swim")
	state_add("follow")
	state_add("shoot")
	call_deferred("state_set", states.idle)
#------------------------------------------------------------------------------#
func _process(_delta: float):
	state_output.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
@warning_ignore("unused_parameter")
func state_logic(delta):
	if state == states.follow:
		p.follow()
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle, states.fall: return basic_move()
	#Follow
		states.follow:
			if !p.detected_player: return states.idle
			elif p.facing.is_colliding(): return states.shoot
	#Shoot
		states.shoot:
			if !p.anim_player.is_playing(): return states.idle
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle: p.anim_player.play("idle")
		states.follow: p.anim_player.play("walk")
		states.shoot: p.anim_player.play("shoot")
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
		states.follow:
			p.velocity = Vector3.ZERO
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move():
	#Swim
	if p.position.y < G.sea_level: return states.swim #When Below Sea Level
	#Player Follow
	if p.detected_player: return states.follow
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
#Swimming Movement
func swim_move():
	if p.check_grounded(): return basic_move() #Expand Logic
#Fly Movement
func fly_move(): pass
