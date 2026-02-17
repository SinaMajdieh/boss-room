## Describes a request to play an animation with resolver metadata.
extends Resource
class_name AnimationRequest


## Animation name to be played.
@export var name: StringName

## Priority used by the animation resolver.
@export var priority: int = 0

## Playback speed multiplier.
@export var speed: float = 1.0

## Whether this animation locks the resolver.
@export var lock: bool = false

## Minimum time (seconds) this animation must play.
@export var min_duration: float = 0.0

## Whether the animation is looped.
@export var looped: bool = false


## Creates an AnimationRequest with sane defaults.
func _init(
	name_: StringName = "",
	priority_: int = 0,
	lock_: bool = false,
	min_duration_: float = 0.0,
	speed_: float = 1.0,
	looped_: bool = false
) -> void:
	name = name_
	priority = priority_
	lock = lock_
	min_duration = min_duration_
	speed = speed_
	looped = looped_
