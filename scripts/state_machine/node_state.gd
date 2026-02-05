extends Node
class_name NodeState

## Enable debug output for state transitions
@export var debug: bool = false

## Emitted when transitioning from one state to another
signal transition(from_state_name: String, to_state_name: String)

## Called every frame. Override in subclasses for frame-based logic
func on_process(_delta: float) -> void:
    pass

## Called every physics frame. Override in subclasses for physics-based logic
func on_physics_process(_delta: float) -> void:
    pass

## Called when entering this state
func enter(_previous_state: String) -> void:
    if debug:
        print_rich("[color=green]Entered %s State" % name)

## Called when exiting this state
func exit() -> void:
    if debug:
        print_rich("[color=red]Exited %s State" % name)

## Override to define conditions that allow transitioning away from this state
func can_transition() -> bool:
    return true

## Emits transition signal to request a state change
func transition_to(state_name: String) -> void:
    transition.emit(name, state_name)