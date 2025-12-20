extends Area2D
class_name HurtBox

@export var shape: CollisionShape2D
@export var damage: float = 1.0

var entities: Array[Node] = []
var active: bool = false:
	get = is_active

func _ready() -> void:
	disable()
	visible = false

func enable() -> void:
	entities.clear()
	monitoring = true
	shape.disabled = false
	active = true

func disable() -> void:
	monitoring = false
	shape.disabled = true
	active = false

func _on_area_entered(area: Area2D) -> void:
	if not area:
		return
	if area in entities or not area.has_method("hurt"):
		return
	entities.append(area)
	area.hurt(damage)

func is_active() -> bool:
	return active

func was_a_hit() -> bool:
	return entities.size() > 0