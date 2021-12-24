extends Node
class_name BattlerStats

signal died()
signal health_changed(value)

export (float, 1, 100, 1) var maxHealth
export (float, 1, 100, 1) var attackPower

var currentHealth : float setget set_health

func _ready():
	currentHealth = maxHealth

func initialize():
	currentHealth = maxHealth

func set_health(value : float):
	currentHealth = clamp(value, 0, maxHealth)
	emit_signal("health_changed", currentHealth)
	
	if is_zero_approx(currentHealth):
		emit_signal("died")
