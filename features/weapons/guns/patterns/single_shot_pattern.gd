## Fire pattern that spawns a single projectile per shot.
extends FirePattern
class_name SingleShotFirePattern


func update(_delta: float) -> void:
	if not gun:
		return
	if not firing:
		return
	if not gun.cool_down_timer.is_stopped():
		return

	spawn_projectile()
	play_muzzle_flash()
	gun.cool_down_timer.start(data.cool_down_time)
