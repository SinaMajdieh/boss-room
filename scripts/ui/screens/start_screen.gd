extends BaseScreen

@export var label: Label
@export var blink_animation: TweenProperty = TweenProperty.new(0.9)

var tween: Tween


func _ready() -> void:
	set_process_input(true)


func start_blink() -> void:
	label.modulate.a = 1.0
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(
		label, "modulate:a", 0.25, blink_animation.duration
	).set_trans(blink_animation.transition_type).set_ease(blink_animation.ease_type)
	tween.tween_property(
		label, "modulate:a", 1.0, blink_animation.duration
	).set_trans(blink_animation.transition_type).set_ease(blink_animation.ease_type)


func stop_blink() -> void:
	if tween:
		tween.kill()


func show_screen() -> void:
	start_blink()
	show()
	show_finished.emit()


func hide_screen() -> void:
	stop_blink()
	hide()
	hide_finished.emit()
