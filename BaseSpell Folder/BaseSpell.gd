extends Resource
class_name BaseSpell

export (String) var spellName = "Base Spell"
export (float, 1, 10000, 100) var AtkPwr : float = 100
export (float, 1, 10000, 100) var DefPwr : float = 100

var isEnabled : bool = true
