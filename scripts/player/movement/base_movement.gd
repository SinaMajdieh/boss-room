extends Node
class_name PlayerMovement

@export_category("Components")
@export var player: Player
var facing_left: bool = false

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

func face(direction: float) -> void:
    if direction > 0 and facing_left:
        player.transform.x *= -1
        facing_left = false
    if direction < 0 and not facing_left:
        player.transform.x *= -1
        facing_left = true