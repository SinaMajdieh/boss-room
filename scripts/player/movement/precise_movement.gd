extends PlayerMovement

@export_category("Horizontal Movement Parameters")
@export var speed: float = 200.0

@export_category("Horizontal Movement Parameters")
@export var jump_force: float = 410.0
@export var gravity_up: float = 900.0
@export var gravity_down: float = 1400.0
@export var gravity_cut: float = 2200

func apply_movement(delta: float) -> void:
	apply_gravity(delta)
	apply_horizontal(delta)

func apply_horizontal(_delta: float) -> void:
	var direction : float = PlayerInput.get_direction()
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0.0, speed)

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
