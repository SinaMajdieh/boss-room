extends Node2D
class_name Pivot

var id: int:
	set = set_id,
	get = get_id

func direction_to(target: Pivot) -> Vector2:
	return global_position.direction_to(target.global_position)

func angle_to(target: Pivot) -> float:
	return global_position.angle_to(target.global_position)

func degrees_angle_to(target: Pivot) -> float:
	return rad_to_deg(angle_to(target))

func set_id(new_id: int) -> void:
	id = new_id

func get_id() -> int:
	return id
