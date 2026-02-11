extends Control
class_name BaseHint

@export var label: Label
@export var animator: BaseUIAnimator

var tween: Tween


func show_hint(message: String) -> void:
	label.text = message
	if animator:
		animator.animate_in(self)
		return
	show()


func hide_hint(_hint_id: StringName):
	if animator:
		animator.animate_out(self)
		return
	hide()
