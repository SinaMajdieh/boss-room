extends GameState


func enter(_previous_state: String) -> void:
    screen_manager.hide_all()
    GameInput.enable_player_input()


func on_process(_delta: float) -> void:
    if UIInput.paused_pressed():
        transition_to("pause")


func exit() -> void:
    GameInput.disable_player_input()