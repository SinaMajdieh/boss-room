extends BaseHint

@export var controller: TutorialController

func _ready() -> void:
	await get_tree().process_frame
	controller = get_tree().get_first_node_in_group("tutorial_controller")
	if not controller:
		push_error("%s: No Tutorial Controller was found" % name)
		return
	controller.hint_requested.connect(show_tutorial_hint)
	controller.hint_cleared.connect(hide_hint)

func show_tutorial_hint(hint: TutorialHint) -> void:
	show_hint(controller.resolve_hint_text(hint))
