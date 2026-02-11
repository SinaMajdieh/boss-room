extends Node
class_name ScreenManager

signal start_game_requested()
signal resume_requested()
signal main_menu_requested()

@export var screens: Dictionary[Screen, Control]
@export var current_screen: Screen = Screen.NONE:
	set(value):
		current_screen = value
		if value == Screen.NONE:
			GameInput.enable_player_input()
		else:
			GameInput.enable_ui_input()


enum Screen{
	NONE,
	START,
	PAUSE,
	DEATH
}


func _connect_signals() -> void:
	screens[Screen.START].start_requested.connect(
		func() -> void:
			start_game_requested.emit()
	)
	screens[Screen.PAUSE].resume_requested.connect(
		func():
			show(Screen.NONE)
			resume_requested.emit()
	)
	screens[Screen.PAUSE].main_menu_requested.connect(
		func():
			main_menu_requested.emit()
	)


func _ready() -> void:
	_connect_signals()
	show(current_screen)


func show(screen: Screen) -> void:
	if current_screen == screen:
		return
	hide_all()
	current_screen = screen

	if screen == Screen.NONE:
		return
	
	var screen_node: Control = screens.get(screen)
	if screen_node:
		screen_node.show()
		screen_node.grab_focus()


func hide_all() -> void:
	for screen in screens.values():
		screen.hide()
	current_screen = Screen.NONE


func show_start() -> void:
	show(Screen.START)


func is_current_screen(screen: Screen) -> bool:
	return screen == current_screen
