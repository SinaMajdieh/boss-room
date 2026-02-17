## Core player character controller.
## Owns and coordinates movement, health, state machine, shooting,
## animations, and combat-related systems.
extends CharacterBody2D
class_name Player


@export_category("Components")
## Visual animation component.
@export var animations: AnimatedSprite

## Handles movement logic (velocity, jumping, knockback, etc).
@export var movement: PlayerMovement

## Player health component.
@export var health: PlayerHealth

## Finite state machine controlling player behavior.
@export var state_machine: StateMachine

## Handles collision enabling / disabling.
@export var collision_controller: PlayerCollisionController

## Animation player for attack-related animations.
@export var attack_animation_player: AnimationPlayer

## Manages equipped guns and weapon switching.
@export var gun_manager: GunManager

## Handles shooting input and logic.
@export var shooting: PlayerShooting

## Resolves animation requests from states and systems.
@export var animation_resolver: AnimationResolver


@export_category("Timers")
## Jump buffer timer.
@export var jump_timer: Timer

## Coyote time timer.
@export var coyote_timer: Timer

## Combo window timer.
@export var combo_timer: Timer

## Invulnerability timer after taking damage.
@export var hurt_timer: Timer

## Shooting cooldown timer.
@export var shoot_cool_down: Timer


## Initializes player connections.
func _ready() -> void:
	## Trigger death when health is depleted.
	health.health_depleted.connect(_on_killed)


## Processes debug-only input and applies movement.
func _process(_delta: float) -> void:
	## Debug input for testing damage.
	if Input.is_action_just_pressed("hurt"):
		hurt()

	if Input.is_action_just_pressed("apply_knock_back"):
		movement.apply_knock_back(5.0 * movement.speed)

	move_and_slide()


## Returns the current state name from the state machine.
func get_state() -> String:
	return state_machine.get_current_state()


## Returns whether the player can currently take damage.
func can_take_damage() -> bool:
	return hurt_timer.is_stopped()


## Applies damage and optional knockback to the player.
func hurt(
	amount: Variant = 1,
	direction: Vector2 = Vector2.ZERO,
	knock_back: float = 0.0
) -> void:
	if not can_take_damage():
		return

	var knock_back_direction := (
		-1.0
		if direction.direction_to(global_position).x < 0.0
		else 1.0
	)

	var hurt_state := state_machine.get_node_state("hurt")
	hurt_state.set_attributes(amount, knock_back_direction * knock_back)

	state_machine.transition(state_machine.current_state_name, "hurt")


## Instantly kills the player.
func kill() -> void:
	health.hurt(health.current_health)


## Transitions the player to the dead state.
func _on_killed() -> void:
	state_machine.transition(state_machine.current_state_name, "dead")


## Returns whether the player is currently dead.
func is_dead() -> bool:
	return health.is_depleted()


## Checks if a given state action is currently allowed.
func can(action: String) -> bool:
	var action_state: PlayerState = state_machine.get_node_state(action)
	if not action_state:
		return false

	return action_state.can_transition()


## Returns whether shooting is allowed in the current state.
func can_shoot() -> bool:
	return state_machine.get_node_state().allow_shooting()
