extends Node2D

onready var stats : BattlerStats = $Stats
onready var menu : PopupMenu = $PlayerUICanvasLayer/PopupMenu

func _ready():
	menu.show()

func _on_Stats_died():
	pass # Replace with function body.

func _on_Stats_health_changed(_value):
	pass # Replace with function body.
