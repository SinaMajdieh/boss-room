extends GameState

@onready var start_screen: BaseScreen = screen_manager.get_screen(Screen.START)


func enter(_previous_state: String) -> void:
    GameInput.enable_ui_input()
    screen_manager.hide_all()
    game_root.unload_level()
    start_screen.show_screen_animated()


func can_transition() -> bool:
    return true if start_screen else false


func start_game() -> void:
    start_screen.hide_screen_animated()
    await start_screen.hide_finished
    transition_to("load")


func on_process(_delta: float) -> void:
    if Input.is_anything_pressed():
        start_game()
