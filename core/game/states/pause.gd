extends GameState

@onready var pause_screen: BaseScreen = screen_manager.get_screen(Screen.PAUSE)


func enter(_previous_state: String) -> void:
	get_tree().paused = true
	GameInput.enable_ui_input(true)
	screen_manager.hide_all()
	pause_screen.resume_requested.connect(_on_resume)
	pause_screen.main_menu_requested.connect(_on_main_menu)
	pause_screen.show_screen_animated()


func can_transition() -> bool:
	return true if pause_screen else false


func _on_resume() -> void:
	pause_screen.hide_screen_animated()
	await pause_screen.hide_finished
	transition_to("playing")


func _on_main_menu() -> void:
	pause_screen.hide_screen()
	transition_to("start")


func on_process(_delta: float) -> void:
	if UIInput.paused_pressed():
		_on_resume()


func exit() -> void:
	get_tree().paused = false
	pause_screen.resume_requested.disconnect(_on_resume)
	pause_screen.main_menu_requested.disconnect(_on_main_menu)
