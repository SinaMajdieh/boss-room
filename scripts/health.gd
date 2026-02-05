extends Node
class_name BaseHealth

## Emitted when health reaches zero or below
signal health_depleted()

## Emitted whenever health value changes
signal health_changed(new_health: Variant)

@export var max_health: Variant = 3

@onready var current_health: Variant = max_health:
    set = set_health,
    get = get_health


## Reduces health by the specified amount and emits health_depleted if health reaches zero
func hurt(amount: Variant = 1) -> void:
    current_health = clamp(current_health - amount, 0, max_health)
    if current_health <= 0:
        depleted()


## Increases health by the specified amount, clamped to max_health
func heal(amount: Variant = 1) -> void:
    current_health += amount
    current_health = clamp(current_health, 0, max_health)


## Emits the health_depleted signal
func depleted() -> void:
    health_depleted.emit()


## Returns true if current health is depleted
func is_depleted() -> bool:
    return current_health <= 0.0


## Internal setter that updates current_health and emits health_changed signal
func set_health(value: Variant) -> void:
    current_health = value
    health_changed.emit(current_health)


## Internal getter for current_health
func get_health() -> Variant:
    return current_health