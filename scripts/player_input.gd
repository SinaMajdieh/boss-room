class_name PlayerInput

static func just_jumped() -> bool:
    return Input.is_action_just_pressed("jump")

static func is_jumping() -> bool:
    return Input.is_action_pressed("jump")

static func just_dashed() -> bool:
    return Input.is_action_just_pressed("dash")

static func get_direction() -> float:
    if is_locked():
        return 0.0
    return Input.get_axis("move_left", "move_right")

static func get_looking_direction(enable_8_way_snapping: bool = true) -> Vector2:
    var vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if enable_8_way_snapping:
        return snap_to_8_way(vector)
    return vector

static func just_attacked() -> bool:
    return Input.is_action_just_pressed("attack")

static func just_shot() -> bool:
    return Input.is_action_just_pressed("shoot")

static func is_shooting() -> bool:
    return Input.is_action_pressed("shoot")

static func is_locked() -> bool:
    return Input.is_action_pressed("lock")

static func snap_to_8_way(vector: Vector2) -> Vector2:
    if vector == Vector2.ZERO:
        return Vector2.RIGHT
    var angle: float = vector.angle()
    var snapped_angle: float = round(angle / (PI / 4)) * (PI / 4)
    return Vector2(cos(snapped_angle), sin(snapped_angle))