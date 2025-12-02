extends Node
class_name PlayerMovement

@export_category("Horizontal Movement Parameters")
@export var speed: float = 200.0
@export var ground_accel: float = 2500.0
@export var ground_decel: float = 3000.0
@export var air_accel: float = 1500.0
@export var air_decel: float = 300.0

@export_category("Horizontal Movement Parameters")
@export var jump_force: float = 410.0
@export var gravity_up: float = 900.0
@export var gravity_down: float = 1400.0
@export var gravity_cut: float = 2200

@export_category("Components")
@export var player: Player

func apply_movement(delta: float) -> void:
	apply_gravity(delta)
	apply_horizontal(delta)

func apply_horizontal(delta: float) -> void:
	var direction : float = PlayerInput.get_direction()
	var target_speed: float = direction * speed
	if direction:
		var accel: float = ground_accel if player.is_on_floor() else air_accel
		player.velocity.x = move_toward(player.velocity.x, target_speed, accel * delta)
	else:
		var decel: float = ground_decel if player.is_on_floor() else air_decel
		player.velocity.x = move_toward(player.velocity.x, 0.0, decel * delta)

func apply_gravity(delta: float) -> void:
	if player.velocity.y < 0.0:
		if PlayerInput.is_jumping():
			player.velocity.y += gravity_up * delta
		else:
			player.velocity.y += gravity_cut * delta
	else:
		player.velocity.y += gravity_down * delta

func process_jump() -> void:
	if not player.jump_timer.is_stopped():
		player.velocity.y = -jump_force
		player.jump_timer.stop()
