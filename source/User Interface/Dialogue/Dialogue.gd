#Inherits CanvasLayer Script
extends CanvasLayer
#------------------------------------------------------------------------------#
@onready var bubble = $Control/Bubble
@onready var bubble_small = $Control/Bubble/Bubble_Small
@onready var bubble_med = $Control/Bubble/Bubble_Med
@onready var bubble_chat = $Control/Bubble/Bubble_Chat
@onready var elipses = $Control/Elipses
@onready var souls_exchange = $Control/SoulsExchange
@onready var upgrade_exchange = $Control/UpgradeExchange
@onready var label = $Control/Label
#------------------------------------------------------------------------------#
#No Chat
func no_chat():
	visible = false
#Beckoning Chat
func beckon():
	visible = true
	bubble.visible = true
	elipses.visible = true
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	label.visible = false
#Challenging Chat
func challenge():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = true
	upgrade_exchange.visible = false
	label.visible = true
