## Running state that reacts to direction changes
## by requesting a turn animation.
extends PlayerState


## Applies horizontal movement.
func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)


## Polls input and checks for transitions.
func on_process(_delta: float) -> void:
	check_falling()
	check_jump_input()
	check_dash()
	check_attack()

	if not player.movement.is_moving():
		transition_to("idle")


## Transitions are only allowed while grounded.
func can_transition() -> bool:
	return player.is_on_floor()


## Shooting is allowed while running.
func allow_shooting() -> bool:
	return true
