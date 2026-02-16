extends Area2D
class_name ProjectileBase

@export var animation: AnimatedSprite
@export var state_machine: StateMachine

@export var speed: float = 800.0
@export var direction: Vector2 = Vector2.RIGHT
@export var damage: float = 1.0
@export var life_time: float = 2.0


## Rotates the bullet sprite to face the direction it's moving.
func rotate_to_direction() -> void:
	rotation = direction.angle()
