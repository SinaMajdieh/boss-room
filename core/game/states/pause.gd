## State responsible for pausing gameplay and showing the pause menu.
extends GameState


## Cached reference to the pause screen.
@onready var pause_screen: BaseScreen = screen_manager.get_screen(Screen.PAUSE)


## Enters pause mode and shows the pause screen.
func enter(_previous_state: String) -> void:
	get_tree().paused = true
	GameInput.enable_ui_input(true)

	screen_manager.hide_all()

	pause_screen.resume_requested.connect(_on_resume)
	pause_screen.main_menu_requested.connect(_on_main_menu)
	pause_screen.show_screen_animated()


## Returns true if this state can safely transition.
func can_transition() -> bool:
	return pause_screen != null


## Handles resume request from the pause screen.
func _on_resume() -> void:
	pause_screen.hide_screen_animated()
	await pause_screen.hide_finished
	transition_to("playing")


## Handles main menu request from the pause screen.
func _on_main_menu() -> void:
	pause_screen.hide_screen()
	transition_to("start")


## Allows resuming via input while paused.
func on_process(_delta: float) -> void:
	if UIInput.paused_pressed():
		_on_resume()


## Cleans up pause state before exiting.
func exit() -> void:
	get_tree().paused = false

	if pause_screen.resume_requested.is_connected(_on_resume):
		pause_screen.resume_requested.disconnect(_on_resume)

	if pause_screen.main_menu_requested.is_connected(_on_main_menu):
		pause_screen.main_menu_requested.disconnect(_on_main_menu)
