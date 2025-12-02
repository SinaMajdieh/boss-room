extends PlayerState

func on_process(_delta):
	if player.is_on_floor():
		transition.emit("idle")

func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)

func can_transition() -> bool:
	return not player.is_on_floor() and player.velocity.y > 0.0
