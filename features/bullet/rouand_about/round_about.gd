extends ProjectileBase
class_name RoundAboutBullet

@export var max_speed: float = 800.0 
@export var decel_time: float = 0.5 # Time in seconds to decelerate to a stop
@export var max_angle: float = -30.0

@onready var offset_angle: float


func _ready() -> void:
	speed = max_speed
	offset_angle = max_angle if direction.x >= 0 else -max_angle
