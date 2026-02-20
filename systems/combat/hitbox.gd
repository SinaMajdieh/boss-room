## Base hitbox component for handling damage and visibility states.
## Attach to an Area2D node and assign an entity with a hurt() method.
extends Area2D
class_name BaseHitBox

signal damaged(damage: Variant, knock_back: Vector2)


func hurt(amount: Variant, knock_back: Vector2 = Vector2.ZERO) -> void:
	damaged.emit(amount, knock_back)


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
