extends Area2D
class_name BaseBullet

@export var speed: float = 800.0
@export var direction: Vector2 = Vector2.RIGHT
@export var damage: float = 1.0
@export var life_time: float = 2.0


func _ready() -> void:
	area_entered.connect(on_hit)
	body_entered.connect(on_hit)
	rotate_to_direction()


func _process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	life_time -= delta
	if life_time <= 0.0:
		queue_free()


## Handles collision with targets and applies damage.
func on_hit(target: Variant) -> void:
	if not target:
		return
	if target.has_method("hurt"):
		target.hurt(damage)
	queue_free()


## Rotates the bullet sprite to face the direction it's moving.
func rotate_to_direction() -> void:
	rotation = direction.angle()
