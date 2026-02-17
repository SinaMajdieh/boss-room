## Initial game state showing the start screen.
extends GameState


## Cached reference to the start screen.
@onready var start_screen: BaseScreen = screen_manager.get_screen(Screen.START)


## Shows the start screen and resets the game.
func enter(_previous_state: String) -> void:
	GameInput.enable_ui_input()
	screen_manager.hide_all()
	game_root.unload_level()
	start_screen.show_screen_animated()


## Returns true if the start screen exists.
func can_transition() -> bool:
	return start_screen != null


## Starts the game after hiding the start screen.
func start_game() -> void:
	start_screen.hide_screen_animated()
	await start_screen.hide_finished
	transition_to("load")


## Starts the game on any input.
func on_process(_delta: float) -> void:
	if Input.is_anything_pressed():
		start_game()
