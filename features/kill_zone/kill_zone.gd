extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area or not area is BaseHitBox:
		return
	area = area as BaseHitBox
	if area.entity.has_method("kill"):
		area.entity.kill()
