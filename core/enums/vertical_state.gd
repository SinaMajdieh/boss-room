## Collection of shared enums and enum-related utility functions.
class_name VerticalState


## Represents vertical aiming or movement intent derived from a direction vector.
enum State {
	UP,
	UP_DIAGONAL,
	STRAIGHT,
	DOWN_DIAGONAL,
	DOWN,
}


## Converts a direction vector into a State using angle-based sectors.
## The circle is divided into 5 vertical regions:
## up, up-diagonal, straight, down-diagonal, down.
static func to_vertical_state(direction: Vector2) -> State:
	# Early out for zero vectors to avoid undefined angles.
	if direction == Vector2.ZERO:
		return State.STRAIGHT

	var sector: float = PI / 4.0
	var half_sector: float = sector * 0.5

	# Normalize angle to the [-PI, PI] range.
	var angle: float = wrapf(direction.angle(), -PI, PI)

	# Horizontal (left or right) is considered STRAIGHT.
	if _is_within(angle, 0.0, half_sector) or _is_within(abs(angle), PI, half_sector):
		return State.STRAIGHT

	# Negative angles point upward, positive angles downward.
	if angle < 0.0:
		if _is_within(angle, -PI / 2.0, half_sector):
			return State.UP
		return State.UP_DIAGONAL

	if _is_within(angle, PI / 2.0, half_sector):
		return State.DOWN
	return State.DOWN_DIAGONAL


## Returns true if [param value] is within [param tolerance] of [param target].
static func _is_within(value: float, target: float, tolerance: float) -> bool:
	return abs(value - target) <= tolerance
