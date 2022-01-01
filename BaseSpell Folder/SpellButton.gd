extends Button

export (Resource) var spellData

onready var atkLabel : Label = $ATKLabel
onready var defLabel : Label = $DEFLabel

func _ready():
	text = spellData.spellName
	atkLabel.text = str(spellData.AtkPwr)
	defLabel.text = str(spellData.DefPwr)
