extends BaseBulletFireState

func on_process(delta: float) -> void:
	# Decelerate, stop, then accelerate backwards
	projectile.speed = move_toward(projectile.speed, -projectile.max_speed, (projectile.max_speed / projectile.decel_time) * delta)
	projectile.offset_angle = move_toward(projectile.offset_angle, 0.0, (abs(projectile.max_angle) / projectile.decel_time) * delta)

	projectile.position += projectile.direction.rotated(deg_to_rad(projectile.offset_angle)).normalized() * projectile.speed * delta

	# Check if the bullet's lifetime has expired
	projectile.life_time -= delta
	if projectile.life_time <= 0.0:
		projectile.queue_free()