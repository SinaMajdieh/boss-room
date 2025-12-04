extends Node
class_name PlayerHealth

signal health_depleted()
signal hearts_changed(new_hearts_count: int)

@export var max_hearts: int = 3

var current_hearts: int = max_hearts:
    set = set_hearts_count,
    get = get_hearts_count

func hurt(hearts: int = 1) -> void:
    current_hearts -= hearts
    current_hearts = clamp(current_hearts, 0, max_hearts)
    if current_hearts <= 0:
        died()

func heal(hearts: int = 1) -> void:
    current_hearts += hearts
    current_hearts = clamp(current_hearts, 0, max_hearts)

func died() -> void:
    health_depleted.emit()

func set_hearts_count(value: int) -> void:
    current_hearts = value
    hearts_changed.emit(current_hearts)

func get_hearts_count() -> int:
    return current_hearts