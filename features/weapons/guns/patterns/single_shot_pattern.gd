## Fire pattern that spawns a single projectile per shot.
extends FirePattern


func update(_delta: float) -> void:
	if not gun:
		return
	if not is_firing:
		return
	if not gun.cool_down_timer.is_stopped():
		return

	gun.spawn_projectile(data.projectile, gun.fire_direction)
	play_muzzle_flash()
	gun.cool_down_timer.start(data.cool_down_time)
