#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Signals
signal soul_update
signal scrap_update
signal kill_update
signal souls_needed
signal soul_challenge1_update
signal soul_challenge2_update
signal soul_challenge3_update
signal scrap_needed
signal scrap_challenge1_update
signal scrap_challenge2_update
signal scrap_challenge3_update
#Variables
var soul_score = 0: set = set_soul_score
var scrap_score = 0: set = set_scrap_score
var kill_score = 0: set = set_kill_score
var souls_needed_value = 3: set = set_souls_needed
var soul_challenge1_complete: bool = false: set = set_soul_challenge1
var soul_challenge2_complete: bool = false: set = set_soul_challenge2
var soul_challenge3_complete: bool = false: set = set_soul_challenge3
var scrap_needed_value = 5: set = set_scrap_needed
var scrap_challenge1_complete: bool = false: set = set_scrap_challenge1
var scrap_challenge2_complete: bool = false: set = set_scrap_challenge2
var scrap_challenge3_complete: bool = false: set = set_scrap_challenge3
#World Variables
var hmap_img: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var hmImage_size = hmap_img.get_width()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
#OnReady Variables
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
@onready var KINEMATICS = get_tree().get_root().get_node("WorldRoot/Kinematics")
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
@onready var ITEMS = get_tree().get_root().get_node("WorldRoot/Items")
#Spawn Locations
@onready var SPAWN_BORDER = get_tree().get_root().get_node("WorldRoot/World_Chunk/WorldBorder/TeleportArm/TeleportPOS")
@onready var SPAWN_GROVE = get_tree().get_root().get_node("WorldRoot/World_Chunk/Locations/Grove/GroveSpawn")
@onready var SPAWN_FORGE = get_tree().get_root().get_node("WorldRoot/World_Chunk/Locations/Ruins_Forge/ForgeSpawn")
@onready var SPAWN_ANVIL = get_tree().get_root().get_node("WorldRoot/World_Chunk/Locations/Ruins_Forge/AnvilSpawn")
#Cameras
@onready var CAMERAS = get_tree().get_root().get_node("WorldRoot/Cameras")
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
#------------------------------------------------------------------------------#
#Challenge Flags
#Souls
func set_souls_needed(value: int):
	souls_needed_value = souls_needed_value + value
	emit_signal("souls_needed")
func set_soul_challenge1(flag: bool):
	soul_challenge1_complete = flag
	emit_signal("soul_challenge1_update")
func set_soul_challenge2(flag: bool):
	soul_challenge2_complete = flag
	emit_signal("soul_challenge2_update")
func set_soul_challenge3(flag: bool):
	soul_challenge3_complete = flag
	emit_signal("soul_challenge3_update")
#Scrap
func set_scrap_needed(value: int):
	scrap_needed_value = scrap_needed_value + value
	emit_signal("scrap_needed")
func set_scrap_challenge1(flag: bool):
	scrap_challenge1_complete = flag
	emit_signal("scrap_challenge1_update")
func set_scrap_challenge2(flag: bool):
	scrap_challenge2_complete = flag
	emit_signal("scrap_challenge2_update")
func set_scrap_challenge3(flag: bool):
	scrap_challenge3_complete = flag
	emit_signal("scrap_challenge3_update")
