extends Area2D
class_name BaseBullet

@export var speed: float = 800.0
@export var direction: Vector2 = Vector2.RIGHT
@export var damage: int = 1
@export var lifetime: float = 2.0

func _ready() -> void:
    area_entered.connect(on_hit)
    rotate_to_direction()

func _process(delta: float) -> void:
    position += direction.normalized() * speed * delta
    lifetime -= delta
    if lifetime <= 0.0:
        queue_free()

func on_hit(target: Area2D) -> void:
    if not target:
        return
    if target.has_method("hurt"):
        target.hurt(damage)
    queue_free()

func rotate_to_direction() -> void:
    rotation = direction.angle()