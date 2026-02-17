## Projectile fire state that handles deceleration, reversal,
## angle correction, movement, and lifetime expiration.
extends ProjectileFireState


## Updates projectile movement and lifetime each frame.
func on_process(delta: float) -> void:
	_update_speed(delta)
	_update_offset_angle(delta)
	_move_projectile(delta)
	_update_lifetime(delta)


## Gradually decelerates the projectile until it reaches reverse max speed.
func _update_speed(delta: float) -> void:
	projectile.speed = move_toward(
		projectile.speed,
		-projectile.max_speed,
		(projectile.max_speed / projectile.decel_time) * delta
	)


## Smoothly returns the projectile's offset angle back to zero.
func _update_offset_angle(delta: float) -> void:
	projectile.offset_angle = move_toward(
		projectile.offset_angle,
		0.0,
		(abs(projectile.max_angle) / projectile.decel_time) * delta
	)


## Moves the projectile based on its rotated direction and current speed.
func _move_projectile(delta: float) -> void:
	var move_direction: Vector2 = projectile.direction \
		.rotated(deg_to_rad(projectile.offset_angle)) \
		.normalized()

	projectile.position += move_direction * projectile.speed * delta


## Decreases lifetime and despawns the projectile when expired.
func _update_lifetime(delta: float) -> void:
	projectile.life_time -= delta
	if projectile.life_time <= 0.0:
		projectile.queue_free()
