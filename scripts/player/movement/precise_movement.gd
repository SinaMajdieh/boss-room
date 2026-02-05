extends PlayerMovement

@export_category("Horizontal Movement Parameters")
@export var speed: float = 200.0

@export_category("Vertical Movement Parameters")
@export var jump_force: float = 410.0
@export var gravity_up: float = 900.0
@export var gravity_down: float = 1400.0
@export var gravity_cut: float = 2200


## Applies gravity and horizontal movement each frame.
func apply_movement(delta: float) -> void:
	apply_gravity(delta)
	apply_horizontal(delta)


## Handles horizontal movement based on input direction.
func apply_horizontal(_delta: float) -> void:
	var direction: float = PlayerInput.get_direction()
	face(direction)
	if direction:
		player.velocity.x = direction * speed
	else:
		decelerate(_delta)


## Decelerates the player's horizontal velocity toward zero.
func decelerate(_delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0.0, speed)


## Applies gravity based on player velocity direction and jump input.
## Reduces gravity when jump input is held, applies higher gravity when falling.
func apply_gravity(delta: float) -> void:
	if player.velocity.y < 0.0:
		if PlayerInput.is_jumping():
			player.velocity.y += gravity_up * delta
		else:
			player.velocity.y += gravity_cut * delta
	else:
		player.velocity.y += gravity_down * delta


## Initiates jump by setting upward velocity if jump timer is active.
func process_jump() -> void:
	if not player.jump_timer.is_stopped():
		player.velocity.y = -jump_force
		player.jump_timer.stop()


## Applies knockback velocity in the opposite direction the player is facing.
func apply_knock_back(knock_back_velocity: float) -> void:
	if not facing_left:
		player.velocity.x = -knock_back_velocity
	else:
		player.velocity.x = knock_back_velocity
