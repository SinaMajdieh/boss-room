extends PlayerState

func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

func on_process(_delta: float) -> void:
	check_movement_input()
	check_jump_input()
	check_falling()
	check_dash()
	check_attack()

func can_transition() -> bool:
	return true
