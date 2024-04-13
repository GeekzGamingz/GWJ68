#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Constants
#------------------------------------------------------------------------------#
#Variables
var hmap_img: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var hmImage_size = hmap_img.get_width()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
var sea_level: float = 4.25
#OnReady Variables
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
@onready var KINEMATICS = get_tree().get_root().get_node("WorldRoot/Kinematics")
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
#------------------------------------------------------------------------------#
#Globals Functions
func get_height(x, z):
	@warning_ignore("narrowing_conversion")
	return hmap_img.get_pixel(fposmod(x, hmImage_size), fposmod(z, hmImage_size)).r * amplitude
