extends PlayerDebugLabel


func _process(_delta: float) -> void:
	if not player:
		return
	text = "Velocity: x: %5.2f y: %5.2f" % [player.velocity.x, player.velocity.y]
