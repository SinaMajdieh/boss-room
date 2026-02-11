extends Control
class_name BaseHint

@export var label: Label
@export var animation_in: TweenProperty = TweenProperty.new(
    0.22,
    Tween.EASE_OUT
)
@export var animation_out: TweenProperty = TweenProperty.new(
    0.15,
    Tween.EASE_IN
)
@export var offset: Vector2 = Vector2(0.0, 8.0)

var tween: Tween


func show_hint(message: String) -> void:
	label.text = message
	_animate_in()


func hide_hint(_hint_id: StringName):
	_animate_out()


func _animate_in():
	if tween:
		tween.kill()

	visible = true
	modulate.a = 0.0
	position += offset

	tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		self, "modulate:a", 1.0, animation_in.duration
		).set_trans(animation_in.transition_type).set_ease(animation_in.ease_type)

	tween.tween_property(
		self, "position", position - offset, animation_in.duration
		).set_trans(animation_in.transition_type).set_ease(animation_in.ease_type)


func _animate_out():
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		self, "modulate:a", 0.0, animation_out.duration
		).set_trans(animation_out.transition_type).set_ease(animation_out.ease_type)

	tween.tween_property(
		self, "position", position + offset, animation_out.duration
		).set_trans(animation_out.transition_type).set_ease(animation_out.ease_type)

	tween.finished.connect(func():
		visible = false
		position -= offset
	)
