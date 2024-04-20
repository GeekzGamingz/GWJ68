#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
var cinematic_playing: bool = false
#Exported Variables
@export_enum("Souls", "Scrap") var objective: String = "Souls"
#OnReady Variables
@onready var state_output = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	state_add("idle_closed")
	state_add("idle_opened")
	state_add("beckon")
	state_add("challenge")
	state_add("turn_in")
	state_add("soulnom")
	state_add("soul_cinematic")
	state_add("forge_cinematic")
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
		states.idle_opened, states.beckon, states.turn_in: p.lookie()
#State Transitions
func transitions(_delta):
	match(state):
	#Basic Movement
		states.idle_closed: if p.detected_player: return states.idle_opened
		states.idle_opened: return basic_move()
		states.beckon: return basic_move()
		states.challenge: return basic_move()
		states.turn_in: 
			if objective == "Souls":
				if G.soul_score >= G.souls_needed_value: return cinematic_order()
			elif objective == "Scrap":
				if G.scrap_score >= G.scrap_needed_value: return cinematic_order()
			return basic_move()
		states.soul_cinematic, states.forge_cinematic:
			if !cinematic_playing: return states.idle_opened
#Enter State
@warning_ignore("unused_parameter")
func state_enter(state_new, state_old):
	match(state_new):
		states.idle_closed:
			p.anim_player.play("idle_closed")
			p.dialogue.no_chat()
		states.idle_opened:
			p.anim_player.play("idle_open")
			p.dialogue.no_chat()
		states.beckon: p.dialogue.beckon()
		states.challenge:
			if objective == "Souls": p.dialogue.challenge_souls()
			elif objective == "Scrap": p.dialogue.challenge_scrap()
		states.turn_in:
			if objective == "Souls": p.dialogue.gibv_souls()
			elif objective == "Scrap": p.dialogue.gibv_scrap()
		states.soul_cinematic: soul_cinematic()
		states.forge_cinematic: forge_cinematic()
#Exit State
@warning_ignore("unused_parameter")
func state_exit(state_old, state_new):
	match(state_old):
		states.idle_closed: pass
#------------------------------------------------------------------------------#
#Verbose Transitions
#Basic Movement
func basic_move():
	if !p.detected_player: return states.idle_closed
	if p.within_turnIn: return states.turn_in
	elif p.within_challenge: return states.challenge
	elif p.within_beckon: return states.beckon
	elif p.detected_player: return states.idle_opened
#Fly Movement
func fly_move(): pass
#------------------------------------------------------------------------------#
#Cinematics
func cinematic_order():
	if G.scrap_challenge3_complete: return states.idle_opened
	elif G.soul_challenge3_complete: return states.forge_cinematic
	elif G.scrap_challenge2_complete: return states.soul_cinematic
	elif G.soul_challenge2_complete: return states.forge_cinematic
	elif G.scrap_challenge1_complete: return states.soul_cinematic
	elif G.soul_challenge1_complete: return states.forge_cinematic
	elif !G.soul_challenge1_complete: return states.soul_cinematic
#Soul Cinematics
func soul_cinematic():
	#Cinematics
	cinematic_playing = true #Toggle Cinematics
	G.CAMERAS.mimi.current = true #Switch to Mimi Cam
	G.PLAYER.controllable = false #Stop Control
	#Objective Update
	G.set_soul_score(-G.souls_needed_value)
	G.set_souls_needed(2)
	objective = "Scrap"
	#Stage Progression
	if G.soul_challenge2_complete:
		G.set_soul_challenge3(true)
		G.PLAYER.get_node("PlayerUI/ProgressBars").gem_3_charged.visible = true
	elif G.soul_challenge1_complete:
		G.set_soul_challenge2(true)
		G.PLAYER.get_node("PlayerUI/ProgressBars").gem_2_charged.visible = true
	elif !G.soul_challenge1_complete:
		G.set_soul_challenge1(true)
		G.PLAYER.get_node("PlayerUI/ProgressBars").gem_1_charged.visible = true
	#Play Animations
	p.anim_player.play("soulnom")
	await p.anim_player.animation_finished
	G.CAMERAS.forge.current = true
	await get_tree().create_timer(3).timeout
	#Releasing Control to Player
	G.PLAYER.camera_arm.camera.current = true #Switch to Player Cam
	G.PLAYER.global_position = G.SPAWN_FORGE.global_position #Teleport
	G.PLAYER.controllable = true #Return Control
	cinematic_playing = false #Toggle Cinematics
#Forge Cinematics
func forge_cinematic():
	#Cinematics
	cinematic_playing = true #Toggle Cinematics
	G.CAMERAS.forge.current = true
	G.PLAYER.controllable = false
	#Objective Update
	G.set_scrap_score(-G.scrap_needed_value)
	G.set_scrap_needed(5)
	objective = "Souls"
	#Stage Progression
	if G.scrap_challenge2_complete:
		G.set_scrap_challenge3(true)
		G.ITEMS.get_node("Soulforge").soulforged.visible = true
	elif G.scrap_challenge1_complete:
		G.set_scrap_challenge2(true)
		G.ITEMS.get_node("Soulforge").masterwork.visible = true
	elif !G.scrap_challenge1_complete:
		G.set_scrap_challenge1(true)
		G.ITEMS.get_node("Soulforge").repaired.visible = true
	#Play Animations
	G.ITEMS.get_node("Soulforge").anim_player.play("strike")
	await G.ITEMS.get_node("Soulforge").anim_player.animation_finished
	G.ITEMS.get_node("Soulforge").repaired.visible = false
	G.ITEMS.get_node("Soulforge").masterwork.visible = false
	G.ITEMS.get_node("Soulforge").soulforged.visible = false
	#Releasing Control to Player
	G.PLAYER.camera_arm.camera.current = true #Switch to Player Cam
	G.PLAYER.global_position = G.SPAWN_ANVIL.global_position #Teleport
	G.PLAYER.controllable = true #Return Control
	G.PLAYER.mesh.upgrade() #Upgrade Sword
	cinematic_playing = false #Toggle Cinematics
