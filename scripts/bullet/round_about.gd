extends BaseBullet
class_name RoundAboutBullet

@export var max_speed: float = 800.0 
@export var decel_time: float = 0.5 # Time in seconds to decelerate to a stop
@export var max_angle: float  = -30.0

@onready var offset_angle: float


func _ready() -> void:
	super()
	speed = max_speed
	offset_angle = max_angle if direction.x >= 0 else -max_angle


func _process(delta: float) -> void:
	# Decelerate, stop, then accelerate backwards
	speed = move_toward(speed, -max_speed, (max_speed / decel_time) * delta)
	offset_angle = move_toward(offset_angle, 0.0, (abs(max_angle) / decel_time) * delta)

	position += direction.rotated(deg_to_rad(offset_angle)).normalized() * speed * delta

	# Check if the bullet's lifetime has expired
	life_time -= delta
	if life_time <= 0.0:
		queue_free()
