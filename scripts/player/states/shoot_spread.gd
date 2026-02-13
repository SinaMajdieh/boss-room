extends PlayerShootState

@export var stream_angles: Array[float] = [-15.0, 0.0, 15.0]

func shoot() -> void:	
	for angle in stream_angles:
		var bullet_instance: BaseBullet = resource.bullet_scene.instantiate() as BaseBullet
		var shoot_direction: Vector2 = PlayerInput.get_looking_direction(
			player.movement.get_facing_direction()
		).rotated(
			deg_to_rad(angle)
		)
		aim_direction = vertical_states(shoot_direction)
		bullet_instance.position = player.range_attacks.get_bullet_spawn_point(aim_direction)
		bullet_instance.direction = shoot_direction
		get_tree().current_scene.add_child(bullet_instance)

	player.shoot_cool_down.start(resource.shoot_cool_down_time)
