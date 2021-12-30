extends Node2D

var player = null
var enemy = null

func _ready():
	player = Global.player
	enemy = Global.enemy
	
	yield(get_tree().create_timer(0.1), "timeout")
	_enemy_turn_activate()
	
func _player_turn_activate():
	player.start_turn()
	yield(player, "turn_done")
	_enemy_turn_activate()

func _enemy_turn_activate():
	if enemy:
		enemy.attack()
		yield(enemy, "turn_done")
	yield(get_tree().create_timer(0.1), "timeout")
	_player_turn_activate()
