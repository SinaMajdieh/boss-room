extends Area2D
class_name BaseHitBox

@export var entity: Node

func hurt(amount: Variant, knock_back: float = 0.0) -> void:
	if not entity:
		push_warning("No health component")
		return
	entity.hurt(amount, knock_back)

func disable() -> void:
	monitoring = false
	monitorable = false
	visible = false

func enable() -> void:
	monitoring = true
	monitorable = true
	visible = true
