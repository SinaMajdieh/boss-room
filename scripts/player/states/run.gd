extends PlayerState

func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

func on_process(_delta: float) -> void:
	check_falling()
	check_jump_input()
	check_dash()
	if player.velocity.x == 0:
		transition.emit("idle")

func can_transition() -> bool:
	return player.is_on_floor()
