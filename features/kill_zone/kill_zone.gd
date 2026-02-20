## Area that instantly kills any entity entering it
## if the entity exposes a `kill()` method.
extends Area2D


## Connects area collision signal.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


## Handles collision with other areas.
func _on_area_entered(area: Area2D) -> void:
	if not area or not area is BaseHitBox:
		return
	area.hurt(INF)
