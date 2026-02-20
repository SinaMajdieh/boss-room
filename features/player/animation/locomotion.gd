extends AnimationModule
class_name AnimationLocomotionModule

# Dependencies
@export var player: Player

# Tunables
@export var run_speed_threshold: float = 0.6
@export var idle_speed_threshold: float = 0.3


# Exposed state (read by other modules if needed)
@export var is_on_floor: bool = false
@export var is_running: bool = false


# Update
func update() -> void:
	var input_speed: float = abs(PlayerInput.get_direction())

	is_on_floor = player.is_on_floor()

	## Hysteresis to avoid idle/run flicker
	if input_speed > run_speed_threshold:
		is_running = true
	elif input_speed < idle_speed_threshold:
		is_running = false
