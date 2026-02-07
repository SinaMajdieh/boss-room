extends Node
class_name BaseMovement

var facing_left: bool = false

func apply_movement(_delta: float) -> void:
    pass

func apply_horizontal(_delta: float) -> void:
    pass

func decelerate(_delta: float) -> void:
    pass

func apply_gravity(_delta: float) -> void:
    pass

func apply_knock_back(_knock_back_velocity: float) -> void:
    print_rich("[color=yellow]apply_knock_back needs to be implemented")

func process_jump() -> void:
    pass

func face(_direction: float) -> void:
    pass