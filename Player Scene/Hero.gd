extends Node2D

signal _health_depleted()
signal _health_changed(previousValue, nextValue)
signal _turn_done()

export (int, 1, 100) var maxHealth
export (int, 1, 100) var attack

var currentHealth : int

onready var playerMenu : PopupMenu = $PlayerUI/PopupMenu
onready var anim : AnimationPlayer = $AnimationPlayer

func _ready():
	playerMenu.popup()
	set_health(maxHealth)

func set_health(value : int):
	var previousValue = currentHealth
# warning-ignore:narrowing_conversion
	currentHealth = clamp(value, 0, maxHealth)
	emit_signal("_health_changed", previousValue, currentHealth)
	
	if currentHealth <= 0:
		emit_signal("_health_depleted")

func _return_to_idle():
	anim.play("Idle")
	emit_signal("_turn_done")

func _on_PopupMenu_id_pressed(id):
	
	match id:
		0:
			anim.play("Attack")
			pass
			
		1:
			print("Defend")
			pass
