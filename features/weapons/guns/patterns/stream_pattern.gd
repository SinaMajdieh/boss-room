## Fire pattern that spawns multiple projectiles in a spread.
extends FirePattern


## Angle offsets (degrees) applied to the fire direction.
@export var stream_angles: Array[float] = [-20.0, 0.0, 20.0]


func update(_delta: float) -> void:
	if not gun:
		return
	if not is_firing:
		return
	if not gun.cool_down_timer.is_stopped():
		return

	for angle_offset: float in stream_angles:
		var direction : Vector2 = gun.fire_direction.rotated(deg_to_rad(angle_offset))
		gun.spawn_projectile(data.projectile, direction)

	play_muzzle_flash()
	gun.cool_down_timer.start(data.cool_down_time)
