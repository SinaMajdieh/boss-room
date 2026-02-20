extends AnimationTreeBase
class_name PlayerAnimationTree


@export var locomotion: AnimationLocomotionModule
@export var action: AnimationActionModule


## Triggers dash animation with a specific duration.
func trigger_dash(duration: float) -> void:
	action.trigger_dash(duration)


## Triggers death animation state.
func trigger_death() -> void:
	action.trigger_death()
