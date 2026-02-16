## Boss character with health management and gravity physics.
extends CharacterBody2D
class_name Boss

## Reference to the boss health component.
@export_category("Components")
@export var health: BossHealth
@export var movement: BossMovement
@export var pivots: Pivots
@export var state_machine: StateMachine
@export var collision: CollisionShape2D


func _ready() -> void:
	health.health_changed.connect(health_changed)


func _physics_process(_delta: float) -> void:
	move_and_slide()


## Damages the boss by the specified amount.
func hurt(amount: Variant, _direction: Vector2 = Vector2.ZERO, _knock_back: float = 0.0) -> void:
	health.hurt(amount)


## Called when the boss health changes. Logs the current health status.
func health_changed(new_health: float) -> void:
	print("Now I only have %2.2f/%2.2f!" % [new_health, health.max_health])


## Sets the anchor point for the boss.
func set_anchor_to(anchor_name: String) -> void:
	pivots.set_anchor_to(self, pivots.get_pivot(anchor_name))


## Gets the current state of the boss.
func get_state() -> String:
	return state_machine.get_current_state()


## Checks if the boss is collapsed.
func is_collapsed() -> bool:
	var top_anchor: Pivot = pivots.get_pivot("top")
	var center_anchor: Pivot = pivots.get_pivot("center")
	var direction: Vector2 = abs(center_anchor.direction_to(top_anchor))
	return true if is_zero_approx(direction.y) and is_equal_approx(direction.x, 1) else false


## Transitions the player to the dead state when health reaches zero
func die() -> void:
	state_machine.transition(state_machine.current_state_name, "dead")