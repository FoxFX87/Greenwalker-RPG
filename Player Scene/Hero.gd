extends Node2D

signal _health_depleted()
signal _health_changed(previousValue, nextValue)
signal _turn_done()

export (int, 1, 100) var maxHealth
export (int, 1, 100) var attack

var currentHealth : int setget set_health

onready var playerMenu : PopupMenu = $PlayerUI/PopupMenu
onready var anim : AnimationPlayer = $AnimationPlayer
onready var healthLabel : Label = $PlayerUI/Label

func _enter_tree():
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _start_turn():
	playerMenu.show()

func _ready():
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
	
func _recover_from_damage():
	anim.play("Idle")
	
func _receive_damage(value : int):
	anim.play("Hurt")
	currentHealth -= value

func _deal_damage():
	if Global.enemy:
		Global.enemy._receive_damage()
		Global.enemy.currentHealth -= 1
		print(Global.enemy.currentHealth)

func _on_PopupMenu_id_pressed(id):
	
	match id:
		0:
			anim.play("Attack")
			playerMenu.hide()
			pass
			
		1:
			print("Defend")
			playerMenu.hide()
			emit_signal("_turn_done")
			pass

func _on_Hero__health_changed(_previousValue, _nextValue):
	healthLabel.text = str(currentHealth)
