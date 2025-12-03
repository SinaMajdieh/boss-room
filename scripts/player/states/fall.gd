extends PlayerState

func on_process(_delta):
	if not player.coyote_timer.is_stopped():
		check_jump_input()
	if player.is_on_floor():
		transition.emit("idle")
	check_dash()

func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

func enter(previous_state: String) -> void:
	if previous_state not in ["jump", "dash"]:
		player.coyote_timer.start()

func can_transition() -> bool:
	return not player.is_on_floor() and player.velocity.y >= 0.0
