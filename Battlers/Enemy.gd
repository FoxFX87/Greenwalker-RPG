extends Node2D

signal turn_done()

onready var anim : AnimationPlayer = $AnimationPlayer
onready var stats : BattlerStats = $Stats
onready var label : Label = $Sprite/Label

var hasDied : bool  = false

func _ready():
	Global.enemy = self
	stats.initialize()
	update_label()
	label.show()
	
func _exit_tree():
	Global.enemy = null

func attack():
	if not hasDied:
		yield(get_tree().create_timer(0.4), "timeout")
		anim.play("Attack")
	
func take_damage(value : float):
	stats.currentHealth -= value
	anim.play("Hurt")
	
func return_to_idle():
	if not hasDied:
		anim.play("Idle")
	else:
		anim.play("Death")

func finish_turn():
	return_to_idle()
	emit_signal("turn_done")

func deal_damage():
	if Global.player:
		var _enemy = Global.player
		_enemy.take_damage(stats.attackPower)

func update_label(value : float = stats.currentHealth):
	label.text = str(value) + "/" + str(stats.maxHealth)

func _on_Stats_died():
	hasDied = true

func _on_Stats_health_changed(value):
	update_label(value)
