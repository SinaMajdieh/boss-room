class_name GameInput

enum InputMode {
    NONE,
    PLAYER,
    UI
}

static var mode: InputMode = InputMode.NONE

static func enable_player_input() -> void:
    mode = InputMode.PLAYER

static func enable_ui_input() -> void:
    mode = InputMode.UI

static func disable_input() -> void:
    mode = InputMode.NONE
    