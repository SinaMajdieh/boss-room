extends Node2D
class_name Pivot

var id: int:
	set = set_id,
	get = get_id


## Gets the direction to another pivot.
func direction_to(target: Pivot) -> Vector2:
	return global_position.direction_to(target.global_position)


## Gets the angle to another pivot.
func angle_to(target: Pivot) -> float:
	return global_position.angle_to(target.global_position)


## Gets the angle to another pivot in degrees.
func degrees_angle_to(target: Pivot) -> float:
	return rad_to_deg(angle_to(target))


## Sets the ID of the pivot.
func set_id(new_id: int) -> void:
	id = new_id


## Gets the ID of the pivot.
func get_id() -> int:
	return id
