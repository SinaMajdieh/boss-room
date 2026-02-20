extends AnimationModule
class_name AnimationActionModule

# Constants
const ANIM_DASH: StringName = "dash"
const ANIM_SHOOT_IDLE: StringName = "shoot_straight"

# Dependencies
@export var player: Player

# Cached state
var aim_direction: Vector2 = Vector2.ZERO
var is_shooting: bool = false
var is_charging: bool = false


func _ready() -> void:
	player.movement.turn_around.connect(trigger_turn)


# Update
func update() -> void:
	_update_state()
	_update_blends()


## Reads gameplay state needed for animation.
func _update_state() -> void:
	aim_direction = PlayerInput.get_looking_direction() * Vector2(1.0, -1.0)
	is_shooting = player.shooting.is_shooting()
	is_charging = player.shooting.is_charging()


## Updates all blend trees and time scales.
func _update_blends() -> void:
	tree.set_param(
		"parameters/Run/RunShootBlend/blend_amount",
		_bool_to_blend(is_shooting)
	)

	tree.set_param(
		"parameters/Idle/IdleShootBlend/blend_amount",
		_bool_to_blend(is_shooting)
	)

	tree.set_param(
		"parameters/Idle/ShootChargeBlend/blend_amount",
		_bool_to_blend(is_charging)
	)

	tree.set_param("parameters/Run/Shoot/blend_position", aim_direction)
	tree.set_param("parameters/Idle/Shoot/blend_position", aim_direction)
	tree.set_param("parameters/Idle/Charge/blend_position", aim_direction)

	tree.set_param(
		"parameters/Idle/ShootTimeScale/scale",
		tree.calculate_time_scale(
			tree.get_animation_length(ANIM_SHOOT_IDLE),
			player.shooting.get_gun_cool_down()
		)
	)


# -------------------------------------------------------------------
# Triggers
# -------------------------------------------------------------------

## Fires turn animation One shots
func trigger_turn() -> void:
	if is_shooting:
		tree.fire_one_shot("parameters/Run/ShootTurnOneShot")
		return
	tree.fire_one_shot("parameters/Run/TurnOneShot")


## Plays dash animation scaled to match duration.
func trigger_dash(duration: float) -> void:
	var length: float = tree.get_animation_length(ANIM_DASH)
	var scale: float = tree.calculate_time_scale(length, duration)

	tree.set_param("parameters/Dash/TimeScale/scale", scale)
	tree.fire_one_shot("parameters/Dash/DashOneShot")
	tree.travel("Dash")


## Transitions to death animation state.
func trigger_death() -> void:
	tree.travel("Death")


# -------------------------------------------------------------------
# Helpers
# -------------------------------------------------------------------

func _bool_to_blend(value: bool) -> float:
	return 1.0 if value else 0.0
