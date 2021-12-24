extends Control

func _ready():
	$PanelContainer/HBoxContainer/AttackOne.grab_focus()

func _on_PlayerUI_visibility_changed():
	$PanelContainer/HBoxContainer/AttackOne.grab_focus()
