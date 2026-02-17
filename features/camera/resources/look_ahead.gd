## Resource defining look-ahead behavior for the player camera.
## Controls how far and how smoothly the camera shifts in the facing direction.
extends Resource
class_name CameraLookAhead


## Distance the camera looks ahead in the facing direction.
@export var look_ahead_distance: float = 96.0

## Time in seconds it takes to react to direction changes.
@export var reaction_time: float = 0.3

## Enables or disables look-ahead behavior.
@export var enabled: bool = true

## Tween ease type used for look-ahead transitions.
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT

## Tween transition type used for look-ahead transitions.
@export var transition_type: Tween.TransitionType = Tween.TRANS_SINE
