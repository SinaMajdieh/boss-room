## Boss character with health management and gravity physics.
extends CharacterBody2D
class_name Boss

@export_category("Components")
## Reference to the boss health component.
@export var health: BossHealth
@export var movement: BossMovement
@export var pivots: Pivots
@export var state_machine: StateMachine


@export var collision: CollisionShape2D
## Gravity acceleration applied when not on floor.
@export var gravity_down: float = 1400.0

func _ready() -> void:
	health.health_changed.connect(health_changed)
	# movement.face(-1.0)



func _physics_process(_delta: float) -> void:
	move_and_slide()

## Damages the boss by the specified amount.
func hurt(amount: Variant, _direction: Vector2, _knock_back: float = 0.0) -> void:
	health.hurt(amount)

## Called when the boss health changes. Logs the current health status.
func health_changed(new_health: float) -> void:
	print("Now I only have %2.2f/%2.2f!" % [new_health, health.max_health])

func set_anchor_to(anchor_name: String) -> void:
	pivots.set_anchor_to(self, pivots.get_pivot(anchor_name))

func get_state() -> String:
	return state_machine.get_current_state()

func is_collapsed() -> bool:
	var top_anchor: Pivot = pivots.get_pivot("top")
	var center_anchor: Pivot = pivots.get_pivot("center")
	var direction: Vector2 = abs(center_anchor.direction_to(top_anchor))
	return true if is_zero_approx(direction.y) and is_equal_approx(direction.x, 1) else false