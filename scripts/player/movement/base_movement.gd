extends Node
class_name PlayerMovement

@export_category("Components")
@export var player: Player
var facing_left: bool = false

# Base methods to be overridden by subclasses
func apply_movement(_delta: float) -> void:
    pass

func apply_horizontal(_delta: float) -> void:
    pass

func decelerate(_delta: float) -> void:
    pass

func apply_gravity(_delta: float) -> void:
    pass

# Flips player sprite and updates facing direction
func apply_knock_back(_knock_back_velocity: float) -> void:
    print_rich("[color=yellow]apply_knock_back needs to be implemented")

func process_jump() -> void:
    pass

# Flips player sprite when direction changes
func face(direction: float) -> void:
    if direction > 0 and facing_left:
        player.transform.x *= -1
        facing_left = false
    if direction < 0 and not facing_left:
        player.transform.x *= -1
        facing_left = true

func get_facing_direction() -> Vector2:
    return Vector2.LEFT if facing_left else Vector2.RIGHT