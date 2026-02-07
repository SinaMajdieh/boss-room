extends CharacterBody2D
class_name Player

@export_category("Components")
@export var movement: BaseMovement
@export var health: PlayerHealth
@export var state_machine: StateMachine	 
@export var collision_controller: PlayerCollisionController
@export var attack_animation_player: AnimationPlayer

@export_category("Timers")
@export var jump_timer: Timer
@export var coyote_timer: Timer
@export var combo_timer: Timer
@export var hurt_timer: Timer

func _ready() -> void:
	health.health_depleted.connect(die)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("hurt"):
		health.hurt()
	if Input.is_action_just_pressed("apply_knock_back"):
		movement.apply_knock_back(5 * movement.speed)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func get_state() -> String:
	return state_machine.get_current_state()

func can_take_damage() -> bool:
	if not hurt_timer.is_stopped():
		return false
	return true

func hurt(amount: Variant, direction: Vector2, knock_back: float = 800) -> void:
	if not can_take_damage():
		return
	var knock_back_direction: float = -1.0 if direction.direction_to(global_position).x < 0 else 1.0
	state_machine.get_node_state("hurt").set_attributes(amount, knock_back_direction * knock_back)
	state_machine.transition(state_machine.current_state_name, "hurt")

func die() -> void:
	state_machine.transition(state_machine.current_state_name, "dead")

func is_dead() -> bool:
	return health.is_depleted()