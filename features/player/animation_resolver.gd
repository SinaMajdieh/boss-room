## Central animation controller for the player AnimationTree.
## Translates gameplay state into animation parameters only.
extends AnimationTree
class_name PlayerAnimationTree


# -------------------------------------------------------------------
# Dependencies
# -------------------------------------------------------------------

@export var player: Player
@onready var playback: AnimationNodeStateMachinePlayback = get("parameters/playback")
@onready var animation_player: AnimationPlayer = get_node(anim_player)

# -------------------------------------------------------------------
# Tunables (designer-friendly)
# -------------------------------------------------------------------

@export_group("Movement Thresholds")
@export var run_speed_threshold: float = 0.6
@export var idle_speed_threshold: float = 0.3

# -------------------------------------------------------------------
# Cached animation state (read-only outside)
# -------------------------------------------------------------------

var input_direction: float = 0.0
var is_running: bool = false
var is_on_floor: bool = true

var aim_direction: Vector2 = Vector2.ZERO
var is_shooting: bool = false
var is_charging: bool = false

# -------------------------------------------------------------------
# Lifecycle
# -------------------------------------------------------------------

func _ready() -> void:
	active = true
	player.movement.turn_around.connect(trigger_turn)


func _physics_process(_delta: float) -> void:
	_update_cached_state()
	_update_state_machine_conditions()
	_update_blend_parameters()
	print(playback.get_current_node())


# -------------------------------------------------------------------
# State collection
# -------------------------------------------------------------------

## Pulls all relevant state from Player and subsystems.
func _update_cached_state() -> void:
	input_direction = abs(PlayerInput.get_direction())
	aim_direction = PlayerInput.get_looking_direction() * Vector2(1.0, -1.0)

	is_on_floor = player.is_on_floor()

	is_shooting = player.shooting.is_shooting()
	is_charging = player.shooting.is_charging()

	_update_running_state()


## Applies hysteresis to avoid idle/run flickering.
func _update_running_state() -> void:
	if input_direction > run_speed_threshold:
		is_running = true
	elif input_direction < idle_speed_threshold:
		is_running = false


# -------------------------------------------------------------------
# State machine conditions
# -------------------------------------------------------------------

## These booleans are meant to be read by AnimationTree transitions.
func _update_state_machine_conditions() -> void:
	# Exposed as parameters if your state machine uses them
	set("parameters/conditions/is_running", is_running)
	set("parameters/conditions/is_on_floor", is_on_floor)


# -------------------------------------------------------------------
# Blend & playback parameters
# -------------------------------------------------------------------

## Updates blend trees, blend spaces, and time scales.
func _update_blend_parameters() -> void:
	_update_idle_parameters()
	_update_run_parameters()


func _update_idle_parameters() -> void:
	set("parameters/Idle/IdleShootBlend/blend_amount", _bool_to_blend(is_shooting))
	set("parameters/Idle/ShootCharge/blend_amount", _bool_to_blend(is_charging))

	set("parameters/Idle/IdleShootDirection/blend_position", aim_direction)
	set("parameters/Idle/IdleChargeDirection/blend_position", aim_direction)

	set(
		"parameters/Idle/IdleShootTimeScale/scale",
		_calculate_time_scale(
			animation_player.get_animation("shoot_straight").length,
			player.shooting.get_gun_cool_down()
		)
	)


func _update_run_parameters() -> void:
	set("parameters/Run/RunShootBlend/blend_amount", _bool_to_blend(is_shooting))
	set("parameters/Run/Shoot/blend_position", aim_direction)


# -------------------------------------------------------------------
# One-shot triggers
# -------------------------------------------------------------------

## Called by movement / FSM when a turn happens.
func trigger_turn() -> void:
	print("turn")
	_fire_one_shot("parameters/Run/TurnOneShot")
	_fire_one_shot("parameters/Run/ShootTurnOneShot")


func trigger_dash(duration: float ) -> void:
	var time_scale: float = _calculate_time_scale(
		animation_player.get_animation("dash").length, 
		duration
	)
	set("parameters/Dash/TimeScale/scale", time_scale)
	_fire_one_shot("parameters/Dash/DashOneShot")
	playback.travel("Dash")

func trigger_death() -> void:
	playback.travel("Death")

# -------------------------------------------------------------------
# Helpers
# -------------------------------------------------------------------

func _fire_one_shot(path: String) -> void:
	set(
		"%s/request" % path,
		AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE
	)


func _calculate_time_scale(length: float, duration: float) -> float:
	if duration <= 0:
		duration = length
	return length / duration


func _bool_to_blend(value: bool) -> float:
	return 1.0 if value else 0.0
