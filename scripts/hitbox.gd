extends Area2D
class_name BaseHitBox

@export var health: BaseHealth

func hurt(amount: Variant) -> void:
    if not health:
        return
    health.hurt(amount)

func disable() -> void:
    monitoring = false
    visible = false

func enable() -> void:
    monitoring = true
    visible = true