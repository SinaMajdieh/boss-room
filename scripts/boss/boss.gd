## Boss character with health management and gravity physics.
extends CharacterBody2D

@export_category("Components")
## Reference to the boss health component.
@export var health: BossHealth

## Gravity acceleration applied when not on floor.
@export var gravity_down: float = 1400.0


func _ready() -> void:
	health.health_changed.connect(health_changed)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity_down * delta
	move_and_slide()


## Damages the boss by the specified amount.
func hurt(amount: Variant, _knock_back: float = 0.0) -> void:
	health.hurt(amount)


## Called when the boss health changes. Logs the current health status.
func health_changed(new_health: float) -> void:
	print("Now I only have %2.2f/%2.2f!" % [new_health, health.max_health])
