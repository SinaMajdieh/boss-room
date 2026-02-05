class_name PlayerInput

static func just_jumped() -> bool:
    return Input.is_action_just_pressed("jump")

static func is_jumping() -> bool:
    return Input.is_action_pressed("jump")

static func just_dashed() -> bool:
    return Input.is_action_just_pressed("dash")

static func get_direction() -> float:
    return Input.get_axis("left", "right")

static func just_attacked() -> bool:
    return Input.is_action_just_pressed("attack")

static func just_shot() -> bool:
    return Input.is_action_just_pressed("shoot")

static func is_shooting() -> bool:
    return Input.is_action_pressed("shoot")