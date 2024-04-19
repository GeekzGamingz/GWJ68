#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Signals
signal soul_update
signal scrap_update
signal kill_update
#Variables
var soul_score = 0: set = set_soul_score
var scrap_score = 0: set = set_scrap_score
var kill_score = 0: set = set_kill_score
#World Variables
var hmap_img: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var hmImage_size = hmap_img.get_width()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
#OnReady Variables
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
@onready var KINEMATICS = get_tree().get_root().get_node("WorldRoot/Kinematics")
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
@onready var ITEMS = get_tree().get_root().get_node("WorldRoot/Items")
@onready var SPAWN = get_tree().get_root().get_node("WorldRoot/World_Chunk/WorldBorder/TeleportArm/TeleportPOS")
#------------------------------------------------------------------------------#
#Globals Functions
func get_height(x, z):
	@warning_ignore("narrowing_conversion")
	return hmap_img.get_pixel(fposmod(x, hmImage_size), fposmod(z, hmImage_size)).r * amplitude
#------------------------------------------------------------------------------#
#Scoreboard
#Souls
func set_soul_score(value: int):
	soul_score = soul_score + value
	emit_signal("soul_update")
#Scrap
func set_scrap_score(value: int):
	scrap_score = scrap_score + value
	emit_signal("scrap_update")
#Kills
func set_kill_score(value: int):
	kill_score = kill_score + value
	emit_signal("kill_update")
