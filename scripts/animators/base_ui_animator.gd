extends Node
class_name BaseUIAnimator

@export_category("Animation Properties")
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


func animate_in(node: Control):
	if tween:
		tween.kill()

	node.visible = true
	node.modulate.a = 0.0
	node.position += offset

	tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		node, "modulate:a", 1.0, animation_in.duration
		).set_trans(animation_in.transition_type).set_ease(animation_in.ease_type)

	tween.tween_property(
		node, "position", node.position - offset, animation_in.duration
		).set_trans(animation_in.transition_type).set_ease(animation_in.ease_type)


func animate_out(node):
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		node, "modulate:a", 0.0, animation_out.duration
		).set_trans(animation_out.transition_type).set_ease(animation_out.ease_type)

	tween.tween_property(
		node, "position", node.position + offset, animation_out.duration
		).set_trans(animation_out.transition_type).set_ease(animation_out.ease_type)

	tween.finished.connect(func():
		node.visible = false
		node.position -= offset
	)
