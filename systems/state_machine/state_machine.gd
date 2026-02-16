extends Node
class_name StateMachine

## Emitted when the state machine transitions to a new state
signal state_changed(new_state)

@export var initial_state: NodeState
@export var debug: ConsolDebug = ConsolDebug.new()

var states: Dictionary[String, NodeState]
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


## Sets the current state and triggers its enter callback
func set_state(state: NodeState) -> void:
	if not state:
		return
	var previous_state_name: String = current_state_name
	current_state = state
	current_state_name = state.name.to_lower()
	state.enter(previous_state_name)
	state_changed.emit(current_state_name)


## Recursively collects all NodeState children and connects their transition signals
func add_states(node: Node = self) -> void:
	for child in node.get_children():
		if child is NodeState:
			states[child.name.to_lower()] = child
			child.transition.connect(transition)


## Handles state transitions with validation
## Called when a state requests a transition via its transition signal
func transition(from_state_name: String, to_state_name: String) -> void:
	to_state_name = to_state_name.to_lower()
	from_state_name = from_state_name.to_lower()
	debug.log_message(
		"[%s] transition request from %s to %s (current: %s)" % 
		[name,from_state_name, to_state_name, current_state_name]
	)
	
	
	if current_state_name != from_state_name:
		return
	if to_state_name == current_state_name:
		return

	var new_state: NodeState = states.get(to_state_name)
	
	if not new_state or not new_state.can_transition():
		debug.log_warning("[%s] Cannot transition from %s to %s" % [name, from_state_name, to_state_name])
		return

	if current_state:
		current_state.exit()
	
	set_state(new_state)


## Returns the name of the current state
func get_current_state() -> String:
	return current_state_name


## Retrieves a state node by name
func get_node_state(state_name: String) -> NodeState:
	return states.get(state_name)
