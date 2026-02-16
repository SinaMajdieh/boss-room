extends PlayerDebugLabel


func _process(_delta: float) -> void:
	if not player:
		return
	text = "Position: x: %5.2f y: %5.2f" % [player.position.x, player.position.y]
