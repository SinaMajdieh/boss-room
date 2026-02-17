## Projectile that decelerates and curves its trajectory over time,
## similar to Cuphead-style roundabout bullets.
extends ProjectileBase
class_name RoundAboutBullet


## Maximum movement speed.
@export var max_speed: float = 800.0

## Time in seconds to decelerate to a stop.
@export var decel_time: float = 0.5

## Maximum offset angle applied to trajectory.
@export var max_angle: float = -30.0


## Current offset angle applied to direction.
@onready var offset_angle: float


## Initializes speed and curve direction based on facing.
func _ready() -> void:
	speed = max_speed
	offset_angle = max_angle if direction.x >= 0 else -max_angle
