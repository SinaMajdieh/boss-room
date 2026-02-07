extends BaseMovement
class_name BossMovement

@export_category("Components")
@export var entity: Boss

@export_category("Horizontal Movement Parameters")
@export var speed: float = 100.0
@export var ground_accel: float = 1250.0
@export var ground_decel: float = 1500.0
@export var air_accel: float = 0
@export var air_decel: float = 150.0

@export_category("Horizontal Movement Parameters")
# @export var jump_force: float = 410.0
# @export var gravity_up: float = 900.0
@export var gravity_down: float = 1400.0
# @export var gravity_cut: float = 2200

var direction: float = 0.0:
	set = set_direction,
	get = get_direction

func set_direction(direction_: float) -> void:
	direction = clampf(direction_, -1.0, 1.0)

func get_direction() -> float:
	return clampf(direction, -1.0, 1.0)

func apply_movement(delta: float) -> void:
	apply_gravity(delta)
	apply_horizontal(delta)

func apply_horizontal(delta: float) -> void:
	face(direction)
	var target_speed: float = direction * speed if entity.is_on_floor() else air_accel
	
	if direction:
		var accel: float = ground_accel
		entity.velocity.x = move_toward(entity.velocity.x, target_speed, accel * delta)
	else:
		decelerate(delta)

func decelerate(delta: float) -> void:
	var decel: float = ground_decel if entity.is_on_floor() else air_decel
	entity.velocity.x = move_toward(entity.velocity.x, 0.0, decel * delta)

func apply_gravity(delta: float) -> void:
	if entity.velocity.y >= 0.0:
		entity.velocity.y += gravity_down * delta

func process_jump() -> void:
	return

func apply_knock_back(knock_back_velocity: float) -> void:
	if not facing_left:
		entity.velocity.x = -knock_back_velocity
	else:
		entity.velocity.x = knock_back_velocity

func face(direction_: float) -> void:
	if direction_ > 0 and facing_left:
		entity.transform.x *= -1
		facing_left = false
	if direction_ < 0 and not facing_left:
		entity.transform.x *= -1
		facing_left = true
