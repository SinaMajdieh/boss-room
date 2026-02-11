extends Resource
class_name TutorialHint

@export var id: StringName
@export_multiline var text: String
@export var input_actions: Array[String] = []
@export var show_once: bool = true
@export var clear_on_action: bool = true
