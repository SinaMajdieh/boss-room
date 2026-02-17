## Player jump state.
extends PlayerState


## Applies horizontal movement while airborne.
func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)


## Checks for airborne-related transitions.
func on_process(_delta: float) -> void:
	check_falling()
	check_dash()
	check_attack()


## Handles the initial jump impulse.
func enter(_previous_state: String) -> void:
	player.movement.process_jump()


## Allows transitions while grounded or during coyote time.
func can_transition() -> bool:
	return player.is_on_floor() or not player.coyote_timer.is_stopped()


## Shooting is allowed while jumping.
func allow_shooting() -> bool:
	return true
