#Inherits Kinematics Code
extends Kinematics
class_name Actor
#------------------------------------------------------------------------------#
#Variables
#Bool Variables
var found_wall: bool = false
var found_ledge: bool = false
#OnReady Variables
@onready var camera_arm = $CameraArm
#Detectors
@onready var ground_detectors = $WorldDetectors/GroundDetectors
@onready var wall_detectors = $WorldDetectors/WallDetectors
@onready var f_wall = $WorldDetectors/WallDetectors/F_WallDetector
@onready var b_wall = $WorldDetectors/WallDetectors/B_WallDetector
@onready var l_wall = $WorldDetectors/WallDetectors/L_WallDetector
@onready var r_wall = $WorldDetectors/WallDetectors/R_WallDetector
#------------------------------------------------------------------------------#
#World Detection
func check_grounded():
	for ground_detector in ground_detectors.get_children():
		if ground_detector.is_colliding(): return true
	return false
#Swim Detection
#Raise Ground Detectors
func raise_gDetectors():
	for ground_detector in ground_detectors.get_children():
		ground_detector.position.y += 0.5
#Lower Ground Detectors
func lower_gDetectors():
	for ground_detector in ground_detectors.get_children():
		ground_detector.position.y -= 0.5
