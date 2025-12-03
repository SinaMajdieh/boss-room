extends CharacterBody2D
class_name Player

@export_category("Components")
@export var movement: PlayerMovement
@export var state_machine: StateMachine	 
@export var collision_controller: PlayerCollisionController

@export_category("Timers")
@export var jump_timer: Timer
@export var coyote_timer: Timer

func _physics_process(_delta: float) -> void:
	move_and_slide()

func get_state() -> String:
	return state_machine.get_current_state()
