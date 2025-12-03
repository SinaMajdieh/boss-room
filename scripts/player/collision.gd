extends Node
class_name PlayerCollisionController

@export var collisions: Dictionary[String, CollisionShape2D]
@export var current_collision: CollisionShape2D

func switch(collision_name: String) -> void:
    var collision: CollisionShape2D = collisions.get(collision_name)
    if not collision or collision == current_collision:
        return
    if current_collision:
        _disable_collision(current_collision)
    _enable_collision(collision)
    current_collision = collision
func _disable_collision(collision: CollisionShape2D) -> void:
    collision.disabled = true
    collision.visible = false

func _enable_collision(collision: CollisionShape2D) -> void:
    collision.disabled = false
    collision.visible = true
