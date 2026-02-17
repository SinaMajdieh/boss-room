## Resource providing animation requests for shooting-related player states.
## Maps horizontal and vertical movement states to AnimationRequests.
extends Resource
class_name ShootingAnimations


@export_subgroup("Idle")
## Shooting animations while idle, indexed by vertical state.
@export var idle: Dictionary[VerticalState.State, AnimationRequest] = {}


@export_subgroup("Run")
## Shooting animations while running, indexed by vertical state.
@export var run: Dictionary[VerticalState.State, AnimationRequest] = {}


@export_subgroup("Jump / Fall")
## Shooting animations while airborne (jumping or falling),
## indexed by vertical state.
@export var jump_fall: Dictionary[VerticalState.State, AnimationRequest] = {}


@export_subgroup("Shoot + Run")
## Shooting animations while running and firing simultaneously.
@export var shoot_run: Dictionary[VerticalState.State, AnimationRequest] = {}


## Returns the appropriate AnimationRequest for the given movement state
## and vertical state.
func get_request(
	state: StringName,
	vertical_state: VerticalState.State
) -> AnimationRequest:
	match state:
		"idle":
			return idle.get(vertical_state)

		"run":
			return run.get(vertical_state)

		"jump", "fall":
			return jump_fall.get(vertical_state)

		_:
			return null
