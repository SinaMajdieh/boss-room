extends Node
class_name BaseHealth

signal health_depleted()
signal health_changed(new_health: Variant)

@export var max_health: Variant = 3

@onready var current_health: Variant = max_health:
    set = set_health,
    get = get_health

func hurt(amount: Variant = 1) -> void:
    current_health = clamp(current_health - amount, 0, max_health)
    if current_health <= 0:
        died()

func heal(amount: Variant = 1) -> void:
    current_health += amount
    current_health = clamp(current_health, 0, max_health)

func died() -> void:
    health_depleted.emit()

func set_health(value: Variant) -> void:
    current_health = value
    health_changed.emit(current_health)

func get_health() -> Variant:
    return current_health