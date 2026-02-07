extends PlayerState

func enter(_previous_state: String) -> void:
	player.collision_controller.switch(PlayerCollisionController.State.DEAD)


func on_physics_process(delta: float) -> void:
	if player.velocity.x:
		player.movement.decelerate(delta)
	player.movement.apply_gravity(delta)
