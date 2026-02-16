extends Node
class_name GameRoot

@export var level_root: Node
@export var screen_manager: ScreenManager
@export var state_machine: StateMachine


func load_level(scene: PackedScene) -> void:
    if not level_root:
        push_error("%s: No level root found" % name)
    
    unload_level()
    
    var level: Node = scene.instantiate()
    level_root.add_child(level)


func unload_level() -> void:
    for child: Node in level_root.get_children():
        child.queue_free()
