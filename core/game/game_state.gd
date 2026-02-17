## Base state for all high-level game flow states.
extends NodeState
class_name GameState


## Reference to the main game root.
@export var game_root: GameRoot

## Cached reference to the screen manager.
@onready var screen_manager: ScreenManager = game_root.screen_manager

## Shortcut to Screen enum for readability.
var Screen := ScreenManager.Screen
