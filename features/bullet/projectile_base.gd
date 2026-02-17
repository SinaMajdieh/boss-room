## Base class for all projectile types.
## Holds shared data such as movement, damage, and lifetime.
extends Area2D
class_name ProjectileBase


## Visual representation of the projectile.
@export var animation: AnimatedSprite

## State machine controlling projectile behavior.
@export var state_machine: StateMachine


## Current movement speed.
@export var speed: float = 800.0

## Normalized direction the projectile travels in.
@export var direction: Vector2 = Vector2.RIGHT

## Damage dealt on hit.
@export var damage: float = 1.0

## Remaining lifetime in seconds.
@export var life_time: float = 2.0


## Rotates the projectile to face its movement direction.
func rotate_to_direction() -> void:
	rotation = direction.angle()
