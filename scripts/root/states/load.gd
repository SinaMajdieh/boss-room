extends GameState

@export var tutorial_level: PackedScene


func enter(_previous_state: String) -> void:
    game_root.load_level(tutorial_level)
    transition_to("playing")
