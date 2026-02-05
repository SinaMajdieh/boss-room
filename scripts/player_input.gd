## Handles all player input actions for movement, combat, and abilities.
class_name PlayerInput

## Returns true if the jump action was pressed this frame.
static func just_jumped() -> bool:
    return Input.is_action_just_pressed("jump")

## Returns true while the jump action is held down.
static func is_jumping() -> bool:
    return Input.is_action_pressed("jump")

## Returns true if the dash action was pressed this frame.
static func just_dashed() -> bool:
    return Input.is_action_just_pressed("dash")

## Returns horizontal movement axis (-1.0, 0.0, or 1.0), or 0.0 if input is locked.
static func get_direction() -> float:
    if is_locked():
        return 0.0
    return Input.get_axis("move_left", "move_right")

## Returns the look direction as a normalized Vector2.
## Snaps to 8 cardinal/diagonal directions if [param enable_8_way_snapping] is true.
static func get_looking_direction(enable_8_way_snapping: bool = true) -> Vector2:
    var vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if enable_8_way_snapping:
        return snap_to_8_way(vector)
    return vector

## Returns true if the attack action was pressed this frame.
static func just_attacked() -> bool:
    return Input.is_action_just_pressed("attack")

## Returns true if the shoot action was pressed this frame.
static func just_shot() -> bool:
    return Input.is_action_just_pressed("shoot")

## Returns true while the shoot action is held down.
static func is_shooting() -> bool:
    return Input.is_action_pressed("shoot")

## Returns true while the lock-on action is held down.
static func is_locked() -> bool:
    return Input.is_action_pressed("lock")

## Snaps a direction vector to the nearest of 8 directions (N, NE, E, SE, S, SW, W, NW).
## Returns Vector2.RIGHT if the input vector is zero.
static func snap_to_8_way(vector: Vector2) -> Vector2:
    if vector == Vector2.ZERO:
        return Vector2.RIGHT
    var angle: float = vector.angle()
    var snapped_angle: float = round(angle / (PI / 4)) * (PI / 4)
    return Vector2(cos(snapped_angle), sin(snapped_angle))