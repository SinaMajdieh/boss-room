extends BaseBullet
class_name RoundAboutBullet

@export var max_speed: float = 800.0 
@export var rotation_speed: float = 360.0 * 4 # Degrees per second
@export var decel_time: float = 0.5 # Time in seconds to decelerate to a stop

func _process(delta: float) -> void:
	# Rotate the bullet around its center
	rotation += deg_to_rad(rotation_speed * delta)

	# Decelerate, stop, then accelerate backwards
	speed = move_toward(speed, -max_speed, (max_speed / decel_time) * delta)

	position += direction.normalized() * speed * delta

	# Check if the bullet's lifetime has expired
	life_time -= delta
	if life_time <= 0.0:
		queue_free()