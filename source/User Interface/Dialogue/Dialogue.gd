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
@onready var boss_exchange = $Control/BossExchange
@onready var gibv_pls_souls = $Control/GibvPls_Souls
@onready var gibv_pls_scrap = $Control/GibvPls_Scrap
@onready var gibv_pls_kill = $Control/GibvPls_Kill
@onready var souls_amount = $Control/SoulsNeeded
@onready var scrap_amount = $Control/ScrapNeeded
#------------------------------------------------------------------------------#
func _process(_delta):
	souls_amount.text = str(G.souls_needed_value)
	scrap_amount.text = str(G.scrap_needed_value)
#No Chatw
func no_chat():
	visible = false
#Beckoning Chat
func beckon():
	visible = true
	bubble.visible = true
	elipses.visible = true
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = false
	souls_amount.visible = false
	scrap_amount.visible = false
	gibv_pls_kill.visible = false
	boss_exchange.visible = false
#Challenging Soul Chat
func challenge_souls():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = true
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = false
	souls_amount.visible = true
	scrap_amount.visible = false
	gibv_pls_kill.visible = false
	boss_exchange.visible = false
#Challenging Scrap Chat
func challenge_scrap():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = false
	upgrade_exchange.visible = true
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = false
	souls_amount.visible = false
	scrap_amount.visible = true
	gibv_pls_kill.visible = false
	boss_exchange.visible = false
#Challenging Kill Chat
func challenge_kill():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = false
	souls_amount.visible = false
	scrap_amount.visible = false
	gibv_pls_kill.visible = false
	boss_exchange.visible = true
#Gibv Souls Pls
func gibv_souls():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = true
	gibv_pls_scrap.visible = false
	souls_amount.visible = true
	scrap_amount.visible = false
	gibv_pls_kill.visible = false
	boss_exchange.visible = false
#Gibv Scrap Pls
func gibv_scrap():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = true
	souls_amount.visible = false
	scrap_amount.visible = true
	gibv_pls_kill.visible = false
	boss_exchange.visible = false
#Gibv Kill Pls
func gibv_kill():
	visible = true
	bubble.visible = true
	elipses.visible = false
	souls_exchange.visible = false
	upgrade_exchange.visible = false
	gibv_pls_souls.visible = false
	gibv_pls_scrap.visible = false
	souls_amount.visible = false
	scrap_amount.visible = false
	gibv_pls_kill.visible = true
	boss_exchange.visible = false
