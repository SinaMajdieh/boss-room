extends PlayerState

func on_process(_delta):
	if not player.coyote_timer.is_stopped():
		check_jump_input()
	if player.is_on_floor():
		transition_to("idle")
	check_dash()
	check_attack()
	check_shoot()

func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

func enter(previous_state: String) -> void:
	if previous_state not in ["jump", "dash", "fall_no_coyote"]:
		player.coyote_timer.start()

func can_transition() -> bool:
	return not player.is_on_floor()
