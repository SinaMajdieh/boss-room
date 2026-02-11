extends Control

signal resume_requested
signal main_menu_requested

@export var resume_button : Button
@export var menu_button : Button

func _ready():
	resume_button.pressed.connect(
		func() -> void:
			resume_requested.emit()
	)
	menu_button.pressed.connect(
		func(): main_menu_requested.emit()
	)
