## Active gameplay state.
extends GameState


## Enables gameplay input and hides all screens.
func enter(_previous_state: String) -> void:
	screen_manager.hide_all()
	GameInput.enable_player_input()


## Listens for pause input during gameplay.
func on_process(_delta: float) -> void:
	if UIInput.paused_pressed():
		transition_to("pause")


## Disables gameplay input when leaving this state.
func exit() -> void:
	GameInput.disable_player_input()
