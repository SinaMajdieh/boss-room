extends Node
class_name NodeState

@export var debug: bool = false

signal transition(state_name: String)

func on_process(_delta: float) -> void:
    pass

func on_physics_process(_delta: float) -> void:
    pass

func enter(_previous_state: String) -> void:
    if debug:
        print_rich("[color=green]Entered %s State" % name)

func exit() -> void:
    if debug:
        print_rich("[color=red]Exited %s State" % name)

func can_transition() -> bool:
    return true