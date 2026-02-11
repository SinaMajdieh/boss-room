extends BaseScreen

signal start_requested()

@export var label: Label
@export var blink_animation: TweenProperty = TweenProperty.new(0.9)

var tween: Tween


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	set_process_input(true)


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	
	if event is InputEventKey and event.is_pressed():
		accept_event()
		start_requested.emit()


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


func _on_visibility_changed() -> void:
	if visible:
		start_blink()
		return
	stop_blink()
	