extends Node
class_name BaseMovement

@export var can_take_knock_back: bool = true

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

func apply_knock_back(_knock_back_velocity: float) -> void:
	print_rich("[color=yellow]apply_knock_back needs to be implemented")

func process_jump() -> void:
	pass

func face(_direction: float) -> void:
	pass

func get_facing_direction() -> Vector2:
	return Vector2.LEFT if facing_left else Vector2.RIGHT
