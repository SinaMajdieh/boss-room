extends Node
class_name StateMachine

signal state_changed(new_state)

@export var initial_state: NodeState

var states: Dictionary[String,NodeState]
var current_state: NodeState
var current_state_name: String :
    get = get_current_state

var process: bool = true

func _ready() -> void:
    add_states()
    set_state(initial_state)

func _process(delta: float) -> void:
    if not current_state or not process:
        return
    current_state.on_process(delta)

func _physics_process(delta: float) -> void:
    if not current_state or not process:
        return
    current_state.on_physics_process(delta)

func set_state(state: NodeState) -> void:
    if not state:
        return
    state.enter()
    current_state = state
    current_state_name = state.name.to_lower()
    state_changed.emit(current_state_name)

func add_states(node: Node = self) -> void:
    for child in node.get_children():
        if child is NodeState:
            states[child.name.to_lower()] = child
            child.transition.connect(transition)

func transition(state_name: String) -> void:
    state_name = state_name.to_lower()
    if state_name == current_state_name:
        return

    var new_state: NodeState = states.get(state_name)
    
    if not new_state or not new_state.can_transition():
        return

    if current_state:
        current_state.exit()
    
    set_state(new_state)

func get_current_state() -> String:
    return current_state_name
