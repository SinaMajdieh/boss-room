extends Node
class_name PlayerCollisionController

## Defines the collision states for different player actions
enum State { DEFAULT, DASH, DEAD }

## Maps each state to its corresponding collision shape
@export var collisions: Dictionary[State, CollisionShape2D]
## Maps each state to its corresponding hit box shape
@export var hit_boxes: Dictionary[State, CollisionShape2D]

var current_state: State = State.DEFAULT


func _ready() -> void:
	switch(current_state)


## Switches the player's collision and hit box based on the given state.
## Called when the player changes states (e.g., dash, death).
func switch(state: State) -> void:
	_switch_collision(state)
	_switch_hit_box(state)
	current_state = state


## Disables the current collision shape and enables the new one for the given state.
func _switch_collision(state: State) -> void:
	var new_collision: CollisionShape2D = collisions.get(state)
	var current_collision: CollisionShape2D = collisions.get(current_state)

	if not new_collision or current_state == state:
		return
	call_deferred("_enable_collision", new_collision)
	await get_tree().process_frame
	if current_collision:
		call_deferred("_disable_collision", current_collision)


## Disables the current hit box and enables the new one for the given state.
func _switch_hit_box(state: State) -> void:
	var new_hit_box: CollisionShape2D = hit_boxes.get(state)
	var current_hit_box: CollisionShape2D = hit_boxes.get(current_state)

	if not new_hit_box or current_state == state:
		return
	call_deferred("_enable_collision", new_hit_box)
	await get_tree().process_frame
	if current_hit_box:
		call_deferred("_disable_collision", current_hit_box)


## Disables and hides the given collision shape.
func _disable_collision(collision: CollisionShape2D) -> void:
	collision.disabled = true
	collision.visible = false


## Enables and shows the given collision shape.
func _enable_collision(collision: CollisionShape2D) -> void:
	collision.disabled = false
	collision.visible = true
