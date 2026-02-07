extends Area2D
class_name HurtBox

@export var shape: CollisionShape2D
@export var damage: float = 1.0
@export var affected_group: String = "enemy"

var entities: Array[Node] = []
var active: bool = false:
	get = is_active

func _ready() -> void:
	disable()
	visible = false
	area_entered.connect(_on_area_entered)

## Activates the hurtbox and clears previous hit records.
## Call this when an attack starts (e.g., during attack animation).
func enable() -> void:
	entities.clear()
	monitoring = true
	shape.disabled = false
	active = true

## Deactivates the hurtbox.
## Call this when an attack ends.
func disable() -> void:
	monitoring = false
	shape.disabled = true
	active = false

## Handles collision with entities. Applies damage if target is valid and not already hit.
func _on_area_entered(area: Area2D) -> void:
	if not area:
		return
	if area in entities or not area.has_method("hurt") or not area.is_in_group(affected_group):
		return
	entities.append(area)
	area.hurt(damage, global_position)

## Returns whether the hurtbox is currently active.
func is_active() -> bool:
	return active

## Returns true if this hurtbox has hit at least one entity during its active window.
func was_a_hit() -> bool:
	return entities.size() > 0
