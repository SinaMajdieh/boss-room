## Root node responsible for high-level game flow,
## including level loading and unloading.
extends Node
class_name GameRoot


## Node under which all level scenes are instantiated.
@export var level_root: Node

## Manages UI screens such as menus and overlays.
@export var screen_manager: ScreenManager

## Controls global game states and transitions.
@export var state_machine: StateMachine


## Loads a new level scene, replacing any existing level.
func load_level(scene: PackedScene) -> void:
	if not level_root:
		push_error("%s: No level root found" % name)
		return

	unload_level()

	var level: Node = scene.instantiate()
	level_root.add_child(level)


## Removes and frees all currently loaded levels.
func unload_level() -> void:
	if not level_root:
		return

	for child: Node in level_root.get_children():
		child.queue_free()
