extends Node
class_name TutorialController

signal hint_requested(hint: TutorialHint)
signal hint_cleared(hint_id: StringName)

@export var hide_timer: Timer

var active_hint: TutorialHint = null
var shown_hints: Dictionary[StringName, bool] = {}

func _ready() -> void:
	add_to_group("tutorial_controller")
	hide_timer.timeout.connect(_on_hide_timeout)


func show_hint(hint: TutorialHint) -> void:
	if not hint:
		return
	if hint.show_once and shown_hints.has(hint.id):
		return
	if active_hint == hint:
		hide_timer.stop()
		return

	hide_timer.stop()
	active_hint = hint
	shown_hints[hint.id] = true
	hint_requested.emit(hint)


func clear_hint(hint_id: StringName) -> void:
	if not active_hint or active_hint.id != hint_id:
		return
	hide_timer.start()


func _on_hide_timeout() -> void:
	if not active_hint:
		return
	var id: StringName = active_hint.id
	active_hint = null
	hint_cleared.emit(id)

# func _input(event: InputEvent) -> void:
# 	if not active_hint:
# 		return
	
# 	if not active_hint.clear_on_action:
# 		return
	
# 	for action: String in active_hint.input_actions:
# 		if event.is_action_pressed(action):
# 			clear_hint(active_hint.id)
# 			break


func get_action_display(action: String) -> String:
	var events : Array[InputEvent] = InputMap.action_get_events(action)
	if events.is_empty():
		return action
	
	# Prefer Keyboard
	for event: InputEvent in events:
		if event is InputEventKey:
			return OS.get_keycode_string(event.physical_keycode)
	
	# Fallback (gamepad, mouse, etc.)
	return events[0].as_text()


func resolve_hint_text(hint: TutorialHint) -> String:
	var resolved: String = hint.text

	for action in hint.input_actions:
		var token: String= "{" + action + "}"
		var display := get_action_display(action)
		resolved = resolved.replace(token, display)

	return resolved
