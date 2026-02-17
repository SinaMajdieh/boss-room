## Helper class for polling UI-related input actions.
## All checks here are expected to be gated by GameInput.
class_name UIInput


## Returns true if the pause action was pressed this frame.
static func paused_pressed() -> bool:
	if not GameInput.is_enabled(GameInput.InputMode.UI):
		return false

	return Input.is_action_just_pressed("pause")
