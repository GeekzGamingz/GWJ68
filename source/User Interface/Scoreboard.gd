#Inherits Control COde
extends Control
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var soul_count: Label = $SoulCount
@onready var scrap_count: Label = $ScrapCount
@onready var kill_count: Label = $KillCount
#------------------------------------------------------------------------------#
#Ready Function
func _ready():
	connect_UI()
	update_UI()
#------------------------------------------------------------------------------#
#Connect PlayerUI
func connect_UI():
	G.connect("soul_update", update_UI)
	G.connect("scrap_update", update_UI)
	G.connect("kill_update", update_UI)
#Update User Interface
func update_UI():
	soul_count.text = str(G.soul_score)
	scrap_count.text = str(G.scrap_score)
	kill_count.text = str(G.kill_score)
