extends PlayerState

@export var dash_speed: float = 900.0
@export var dash_timer: Timer
@export var dash_cool_down: Timer

var previous_velocity: float
var dash_direction: float = 0.0

func enter(_previous_state: String) -> void:
	player.collision_controller.switch("dash")
	dash_direction = PlayerInput.get_direction()
	previous_velocity = player.velocity.x
	if not dash_direction:
		dash_direction = 1.0
	
	dash_timer.start()

func on_physics_process(_delta: float) -> void:
	player.velocity.x = dash_direction * dash_speed
	player.velocity.y = 0

func exit() -> void:
	player.collision_controller.switch("default")
	player.velocity.x = 0.0
	dash_timer.stop()
	dash_cool_down.start()


func _on_dash_timer_timeout() -> void:
	if player.is_on_floor():
		transition_to("idle")
	else:
		transition_to("fall")    

func can_transition() -> bool:
	return dash_cool_down.is_stopped()
