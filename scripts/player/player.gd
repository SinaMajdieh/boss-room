extends CharacterBody2D
class_name Player

@export_category("Components")
@export var movement: PlayerMovement
@export var health: PlayerHealth
@export var state_machine: StateMachine
@export var collision_controller: PlayerCollisionController
@export var attack_animation_player: AnimationPlayer
@export var range_attacks: PlayerRangeAttacks

@export_category("Timers")
@export var jump_timer: Timer
@export var coyote_timer: Timer
@export var combo_timer: Timer
@export var hurt_timer: Timer
@export var shoot_cool_down: Timer


func _ready() -> void:
	## Connect health depletion signal to trigger death state
	health.health_depleted.connect(die)


func _process(_delta: float) -> void:
	## Handle debug input for testing damage
	if Input.is_action_just_pressed("hurt"):
		health.hurt()
	if Input.is_action_just_pressed("apply_knock_back"):
		movement.apply_knock_back(5 * movement.speed)


func _physics_process(_delta: float) -> void:
	move_and_slide()


## Returns the current state name from the state machine
func get_state() -> String:
	return state_machine.get_current_state()


## Checks if the player can take damage based on hurt invulnerability timer
func can_take_damage() -> bool:
	return hurt_timer.is_stopped()


## Applies damage to the player and transitions to hurt state
## Parameters: amount - damage dealt, knock_back - knockback force magnitude (default: 800)
func hurt(amount: Variant, knock_back: float = 800) -> void:
	if not can_take_damage():
		return
	state_machine.get_node_state("hurt").set_attributes(amount, knock_back)
	state_machine.transition(state_machine.current_state_name, "hurt")


## Transitions the player to the dead state when health reaches zero
func die() -> void:
	state_machine.transition(state_machine.current_state_name, "dead")


## Returns whether the player is currently dead
func is_dead() -> bool:
	return health.is_depleted()