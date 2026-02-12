class_name GameInput

enum InputMode {
    NONE,
    PLAYER,
    UI
}

static var modes: Dictionary[InputMode, bool] = {}


static func enable_player_input(exclusive: bool = false) -> void:
    if exclusive:
        disable_input()
    modes[InputMode.PLAYER] = true


static func disable_player_input() -> void:
    modes[InputMode.PLAYER] = false


static func enable_ui_input(exclusive: bool = false) -> void:
    if exclusive:
        disable_input()
    modes[InputMode.UI] = true


static func disable_ui_input() -> void:
    modes[InputMode.UI] = false


static func disable_input() -> void:
    for keys: InputMode in modes.keys():
        modes[keys] = false


static func is_enabled(mode: InputMode) -> bool:
    return modes.get(mode, false)
