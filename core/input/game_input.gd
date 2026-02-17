## Centralized input gating system used to enable or disable
## player and UI input based on the current game state.
class_name GameInput


## Defines the available input modes.
enum InputMode {
	NONE,
	PLAYER,
	UI,
}


## Stores whether each input mode is currently enabled.
static var modes: Dictionary[InputMode, bool] = {
	InputMode.PLAYER: true,
	InputMode.UI: true,
}


## Enables player input.
## If [param exclusive] is true, all other input modes are disabled first.
static func enable_player_input(exclusive: bool = false) -> void:
	if exclusive:
		disable_input()

	modes[InputMode.PLAYER] = true


## Disables player input.
static func disable_player_input() -> void:
	modes[InputMode.PLAYER] = false


## Enables UI input.
## If [param exclusive] is true, all othe input modes are disabled first.
static func enable_ui_input(exclusive: bool = false) -> void:
	if exclusive:
		disable_input()

	modes[InputMode.UI] = true


## Disables UI input.
static func disable_ui_input() -> void:
	modes[InputMode.UI] = false


## Disables all input modes.
static func disable_input() -> void:
	for mode: InputMode in modes.keys():
		modes[mode] = false


## Returns true if the given input [param mode] is enabled.
static func is_enabled(mode: InputMode) -> bool:
	return modes.get(mode, false)
