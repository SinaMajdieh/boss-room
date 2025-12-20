extends CharacterBody2D
class_name Player

@export_category("Components")
@export var movement: PlayerMovement
@export var health: PlayerHealth
@export var state_machine: StateMachine	 
@export var collision_controller: PlayerCollisionController
@export var attack_animation_player: AnimationPlayer

@export_category("Timers")
@export var jump_timer: Timer
@export var coyote_timer: Timer
@export var combo_timer: Timer

func _ready() -> void:
	health.health_depleted.connect(die)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("hurt"):
		health.hurt()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func get_state() -> String:
	return state_machine.get_current_state()

func die() -> void:
	state_machine.transition(state_machine.current_state_name, "dead")
