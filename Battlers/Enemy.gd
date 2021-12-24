extends Node2D

signal turn_done()

onready var anim : AnimationPlayer = $AnimationPlayer
onready var stats : BattlerStats = $Stats

var target

func _attack():
	yield(get_tree().create_timer(0.4), "timeout")
	anim.play("Attack")
	
func take_damage(value : float):
	stats.currentHealth -= value
	anim.play("Hurt")
	
func return_to_idle():
	anim.play("Idle")

func finish_turn():
	return_to_idle()
	emit_signal("turn_done")

func _on_Stats_died():
	pass # Replace with function body.

func _on_Stats_health_changed(_value):
	pass # Replace with function body.
