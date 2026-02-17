## Running state that reacts to direction changes
## by requesting a turn animation.
extends PlayerState


## Animation requested when the player turns around.
@export var turn_animation: AnimationRequest


## Connects to movement direction changes.
func enter(_previous_state: String) -> void:
	player.movement.turn_around.connect(_on_turn)


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


## Disconnects movement signals safely.
func exit() -> void:
	if player.movement.turn_around.is_connected(_on_turn):
		player.movement.turn_around.disconnect(_on_turn)


## Transitions are only allowed while grounded.
func can_transition() -> bool:
	return player.is_on_floor()


## Shooting is allowed while running.
func allow_shooting() -> bool:
	return true


## Requests a turn animation when the player changes direction.
func _on_turn() -> void:
	player.animation_resolver.request(turn_animation)
