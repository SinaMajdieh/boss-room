extends PlayerState

@export var MAX_ALLOWED_DASH_COUNT: int = 1

var allowed_dash_count: int = MAX_ALLOWED_DASH_COUNT

## Handles player input and state transitions while falling.
func on_process(_delta):
	if not player.coyote_timer.is_stopped():
		check_jump_input()
	if player.is_on_floor():
		transition_to("idle")
	if allowed_dash_count:
		check_dash()
	check_attack()


## Applies movement physics each frame.
func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)


## Initializes fall state and starts coyote timer if transitioning from certain states.
func enter(previous_state: String) -> void:
	if previous_state not in ["jump", "dash", "fall_no_coyote"]:
		player.coyote_timer.start()
	
	if previous_state == "dash":
		allowed_dash_count -= 1
	else:
		allowed_dash_count = MAX_ALLOWED_DASH_COUNT


## Returns true if player is airborne.
func can_transition() -> bool:
	return not player.is_on_floor()

func allow_shooting() -> bool:
	return true