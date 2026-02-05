## Base hitbox component for handling damage and visibility states.
## Attach to an Area2D node and assign an entity with a hurt() method.
extends Area2D
class_name BaseHitBox

## Reference to the entity that will receive damage (must have hurt method)
@export var entity: Node

## Applies damage to the entity with optional knockback.
## Called when this hitbox detects a collision or is triggered externally.
func hurt(amount: Variant, knock_back: float = 0.0) -> void:
	if not entity:
		push_warning("No health component")
		return
	entity.hurt(amount, knock_back)

## Disables the hitbox and hides it from view.
## Use when the entity dies or enters an invulnerable state.
func disable() -> void:
	monitoring = false
	monitorable = false
	visible = false

## Enables the hitbox and makes it visible again.
## Use when the entity respawns or recovers from invulnerability.
func enable() -> void:
	monitoring = true
	monitorable = true
	visible = true
