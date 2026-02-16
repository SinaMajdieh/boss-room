extends Resource
class_name TweenProperty

@export var duration: float = 1.0
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var transition_type: Tween.TransitionType = Tween.TRANS_SINE

func _init(
    duration_: float = 1.0,
    ease_type_: Tween.EaseType = Tween.EASE_IN_OUT,
    transition_type_: Tween.TransitionType = Tween.TRANS_SINE
) -> void:
    duration = duration_
    ease_type = ease_type_
    transition_type = transition_type_