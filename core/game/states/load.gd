## State responsible for loading the tutorial level.
extends GameState


## Scene used as the tutorial level.
@export var tutorial_level: PackedScene


## Loads the tutorial level and transitions into gameplay.
func enter(_previous_state: String) -> void:
	game_root.load_level(tutorial_level)
	transition_to("playing")
