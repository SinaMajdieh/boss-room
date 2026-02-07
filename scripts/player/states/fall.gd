extends PlayerState

## Handles player input and state transitions while falling.
func on_process(_delta):
	if not player.coyote_timer.is_stopped():
		check_jump_input()
	if player.is_on_floor():
		transition_to("idle")
	check_dash()
	check_attack()
	check_shoot()

## Applies movement physics each frame.
func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

## Initializes fall state and starts coyote timer if transitioning from certain states.
func enter(previous_state: String) -> void:
	if previous_state not in ["jump", "dash", "fall_no_coyote"]:
		player.coyote_timer.start()

## Returns true if player is airborne.
func can_transition() -> bool:
	return not player.is_on_floor()
