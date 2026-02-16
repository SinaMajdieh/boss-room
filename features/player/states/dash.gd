extends PlayerState

@export var dash_speed: float = 2700.0
@export var dash_timer: Timer
@export var dash_cool_down: Timer

var previous_velocity: float
var dash_direction: float = 0.0


func _ready() -> void:
	dash_timer.timeout.connect(_on_dash_timer_timeout)


## Called when entering the dash state. Sets up collision, direction, and starts the dash timer.
func enter(_previous_state: String) -> void:
	super(_previous_state)
	player.collision_controller.switch(PlayerCollisionController.State.DASH)
	dash_direction = player.movement.get_facing_direction().x
	previous_velocity = player.velocity.x
	if not dash_direction:
		dash_direction = 1.0
	
	dash_timer.start()


## Applies constant dash velocity during the dash duration.
func on_physics_process(_delta: float) -> void:
	player.velocity.x = dash_direction * dash_speed
	player.velocity.y = 0


## Cleans up dash state and starts cooldown timer to prevent dash spam.
func exit() -> void:
	player.collision_controller.switch(PlayerCollisionController.State.DEFAULT)
	player.velocity.x = 0.0
	dash_timer.stop()
	dash_cool_down.start()


## Transitions to idle or fall state when dash duration expires.
func _on_dash_timer_timeout() -> void:
	if player.is_on_floor():
		transition_to("idle")
	else:
		transition_to("fall")


## Returns whether dash ability is available (cooldown has finished).
func can_transition() -> bool:
	return dash_cool_down.is_stopped()
