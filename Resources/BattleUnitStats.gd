extends Resource
class_name BattleUnitStats

signal _health_depleted()
signal _health_changed(previousValue, nextValue)

export (int, 1, 100) var maxHealth
export (int, 1, 100) var attack

var currentHealth : int

func reinitialize():
	set_health(maxHealth)

func set_health(value : int):
	var previousValue = currentHealth
# warning-ignore:narrowing_conversion
	currentHealth = clamp(value, 0, maxHealth)
	emit_signal("_health_changed", previousValue, currentHealth)
	
	if currentHealth <= 0:
		emit_signal("_health_depleted")
