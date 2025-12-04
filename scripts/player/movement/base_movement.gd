extends Node
class_name PlayerMovement

@export_category("Components")
@export var player: Player

func apply_movement(_delta: float) -> void:
    pass

func apply_horizontal(_delta: float) -> void:
    pass

func decelerate(_delta: float) -> void:
    pass

func apply_gravity(_delta: float) -> void:
    pass

func process_jump() -> void:
    pass
