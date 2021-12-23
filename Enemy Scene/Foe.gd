extends Node2D

signal _health_depleted()
signal _health_changed(previousValue, nextValue)
signal _turn_done()

export (int, 1, 100) var maxHealth
export (int, 1, 100) var attack

var currentHealth : int setget set_health

onready var anim : AnimationPlayer = $AnimationPlayer
onready var label : Label = $Label

func _enter_tree():
	Global.enemy = self
	
func _exit_tree():
	Global.enemy = null
	
func _ready():
	$Sprite.scale.x = -1
	set_health(maxHealth)
	
func set_health(value : int):
	var previousValue = currentHealth
# warning-ignore:narrowing_conversion
	currentHealth = clamp(value, 0, maxHealth)
	emit_signal("_health_changed", previousValue, currentHealth)
	
	if currentHealth <= 0:
		emit_signal("_health_depleted")

func _attack():
	yield(get_tree().create_timer(0.4), "timeout")
	anim.play("Attack")

func _return_to_idle():
	anim.play("Idle")
	emit_signal("_turn_done")

func _deal_damage():
	if Global.player:
		Global.player._receive_damage(attack)
		print("Player Health: ", Global.player.currentHealth)

func _receive_damage():
	anim.play("Hurt")

func _recover_from_hit():
	anim.play("Idle")

func _on_Foe__health_changed(_previousValue, _nextValue):
	label.text = str(currentHealth)
	pass # Replace with function body.
