#Inherits Kinematics Code
extends Kinematics
class_name Actor
#------------------------------------------------------------------------------#
#Signals
signal health_heal(health)
signal health_damage(health)
#------------------------------------------------------------------------------#
#Variables
#Bool Variables
var found_wall: bool = false
var found_ledge: bool = false
#Exported Variables
@export var max_health: float = 100
#OnReady Variables
@onready var health = max_health: set = set_health
@onready var camera_arm = $CameraArm
@onready var enemy_bars = null
#Detectors
@onready var ground_detectors = $WorldDetectors/GroundDetectors
@onready var wall_detectors = $WorldDetectors/WallDetectors
@onready var f_wall = $WorldDetectors/WallDetectors/F_WallDetector
@onready var b_wall = $WorldDetectors/WallDetectors/B_WallDetector
@onready var l_wall = $WorldDetectors/WallDetectors/L_WallDetector
@onready var r_wall = $WorldDetectors/WallDetectors/R_WallDetector
#------------------------------------------------------------------------------#
#Process Function
func _physics_process(_delta):
	if health <= 0: kill()
#World Detection
func check_grounded():
	for ground_detector in ground_detectors.get_children():
		if ground_detector.is_colliding(): return true
	return false
#------------------------------------------------------------------------------#
#Health
#Heal
func heal(amount):
	set_health(health + amount)
#Damage
func damage(amount):
	set_health(health - amount)
#Set Health
func set_health(value):
	var health_prev = health
	health = clamp(value, 0, max_health)
	if health > health_prev:
		if health == 100: pass
		emit_signal("health_heal", health)
	if health < health_prev:
		emit_signal("health_damage", health)
		if health == 0: kill()
		else: if enemy_bars != null: enemy_bars.visible = true
#Kill Switch
func kill(): pass
