#Inherits Node3D Code
extends Node3D
#------------------------------------------------------------------------------#
#Constants
const SWORD_BROKEN = preload("res://source/Items/Sword_Broken.tscn")
const SWORD_REPAIRED = preload("res://source/Items/Sword_Repaired.tscn")
const SWORD_MASTERWORK = preload("res://source/Items/Sword_Masterwork.tscn")
const SWORD_SOULFORGED = preload("res://source/Items/Sword_Soulforged.tscn")
#------------------------------------------------------------------------------#
#Variables
var sword
var condition_previous
#Exported Variables
@export_enum("Broken", "Repaired", "Masterwork", "Soulforged") var condition: String
#OnReady Variables
@onready var p = get_parent()
#------------------------------------------------------------------------------#
#Ready Function
func _ready(): 
	sword = SWORD_BROKEN.instantiate()
	add_child(sword)
#------------------------------------------------------------------------------#
#Process
func _process(_delta): condition_check()
#------------------------------------------------------------------------------#
func _input(event): #Comment Before Launch
	if event.is_action_pressed("action_upgrade"): upgrade()
	if event.is_action_pressed("action_downgrade"): downgrade()
#------------------------------------------------------------------------------#
#Upgrade Condition
func upgrade():
	match(condition):
		"Broken": condition = "Repaired"
		"Repaired": condition = "Masterwork"
		"Masterwork": condition = "Soulforged"
#Downgrade Condition
func downgrade():
	match(condition):
		"Soulforged": condition = "Masterwork"
		"Masterwork": condition = "Repaired"
		"Repaired": condition = "Broken"
#Check Condition
func condition_check():
	if condition != condition_previous:
		match(condition):
			"Broken": 
				sword = SWORD_BROKEN.instantiate()
				p.anim_player = sword.get_node("AnimationPlayers/AnimationPlayer")
				add_child(sword)
				get_child(0).queue_free()
			"Repaired": 
				sword = SWORD_REPAIRED.instantiate()
				p.anim_player = sword.get_node("AnimationPlayers/AnimationPlayer")
				add_child(sword)
				get_child(0).queue_free()
			"Masterwork":
				sword = SWORD_MASTERWORK.instantiate()
				p.anim_player = sword.get_node("AnimationPlayers/AnimationPlayer")
				add_child(sword)
				get_child(0).queue_free()
			"Soulforged":
				sword = SWORD_SOULFORGED.instantiate()
				p.anim_player = sword.get_node("AnimationPlayers/AnimationPlayer")
				add_child(sword)
				get_child(0).queue_free()
	condition_previous = condition
