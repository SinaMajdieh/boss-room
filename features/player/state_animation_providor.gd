## Provides an AnimationRequest based on the current player state.
## Acts as a simple lookup layer between the StateMachine and animation data.
extends Node
class_name PlayerStateAnimationProvider


@export_category("Data")
## Mapping of state name → animation request.
@export var state_animations: Dictionary[StringName, AnimationRequest]


@export_category("Dependencies")
## State machine used to determine the current player state.
@export var state_machine: StateMachine


## Returns the animation request for the current state.
func get_animation_request() -> AnimationRequest:
	var state: StringName = state_machine.get_current_state()
	return state_animations.get(state)
