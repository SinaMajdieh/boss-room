extends Control
class_name PlayerDebugScreen

@export var labels_container: Control

var player: Player


func _ready() -> void:
	try_get_player()


func _process(_delta: float) -> void:
	if not player:
		hide()
		try_get_player()


func try_get_player() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		set_labels_player()


func set_labels_player() -> void:
	for label: Node in labels_container.get_children():
		if not label is PlayerDebugLabel:
			continue
		label = label as PlayerDebugLabel
		label.set_player(player)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_screen"):
		visible = not visible
