extends Node
class_name PlayerRangeAttacks

@export var attack_states: Array[PlayerState] = []

var current_attack_index: int = 0

## Cycles to the advance_attack attack state in the array.
func advance_attack() -> void:
    if attack_states.is_empty():
        return
    current_attack_index = (current_attack_index + 1) % attack_states.size()

## Returns the currently active attack state, or null if no attacks are available.
func get_current_attack_state() -> PlayerState:
    if attack_states.is_empty():
        return null
    return attack_states.get(current_attack_index)

## Returns the name of the current attack, or "None" if no attack is active.
func get_attack_name() -> String:
    var current_state = get_current_attack_state()
    return current_state.name.to_lower() if current_state else "none"

## Handles input to cycle to the advance_attack attack when the "next_attack" action is pressed.
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("cycle_attack"):
        advance_attack()