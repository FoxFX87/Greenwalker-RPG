extends Node
class_name BaseMage

export (String) var mageName
export (float, 1, 10000, 100) var maxHP : float = 1000
export var spells : Array

onready var curHP : float = maxHP

var isAttacking : bool = false
