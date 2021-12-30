extends Node2D

signal turn_done()

onready var anim : AnimationPlayer = $AnimationPlayer
onready var stats : BattlerStats = $Stats
onready var menu : Control = $PlayerUICanvasLayer/PlayerUI
onready var label : Label = $Sprite/Label

func _ready():
	stats.initialize()
	Global.player = self
	
func _exit_tree():
	Global.player = null

func start_turn():
	anim.play("Idle")
	menu.show()

func test_return_turn():
	anim.play("Idle")
	menu.show()

func take_damage(value : float):
	stats.currentHealth -= value
	anim.play("Hurt")
	
func return_to_idle():
	anim.play("Idle")

func finish_turn():
	return_to_idle()
	emit_signal("turn_done")

func deal_damage():
	if Global.enemy:
		var _enemy = Global.enemy
		_enemy.take_damage(stats.attackPower)

func _on_AttackOne_pressed():
	anim.play("Attack")
	menu.hide()
	pass # Replace with function body.

func _on_AttackTwo_pressed():
	menu.hide()
	yield(get_tree().create_timer(1.0), "timeout")
	test_return_turn()

func _on_Stats_health_changed(value):
	label.text = str(value) + "/" + str(stats.maxHealth)
