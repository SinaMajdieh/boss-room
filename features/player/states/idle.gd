## Base ground movement state allowing full player control.
extends PlayerState


## Applies horizontal movement using the movement component.
func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)


## Polls input and checks for possible state transitions.
func on_process(_delta: float) -> void:
	check_movement_input()
	check_jump_input()
	check_falling()
	check_dash()
	check_attack()


## This state may always transition.
func can_transition() -> bool:
	return true


## Shooting is allowed in this state.
func allow_shooting() -> bool:
	return true
