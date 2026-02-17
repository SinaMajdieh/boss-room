## Camera responsible for following the player with optional
## smoothing and look-ahead behavior.
extends Camera2D
class_name PlayerCamera


## Minimum allowed smoothing distance.
const MIN_SMOOTHING_DISTANCE: int = 1
## Maximum allowed smoothing distance.
const MAX_SMOOTHING_DISTANCE: int = 100
## Scale used to convert smoothing distance into a lerp weight.
const SMOOTHING_SCALE: int = 1000


@export_category("Follow Player")
## Player node followed by the camera.
@export var player: Player


@export_category("Camera Smoothing")
## Resource controlling camera smoothing behavior.
@export var smoothing: CameraSmoothing = CameraSmoothing.new()


@export_category("Look Ahead")
## Resource controlling camera look-ahead behavior.
@export var look_ahead: CameraLookAhead = CameraLookAhead.new()


## Tween used for look-ahead direction transitions.
var tween: Tween

## Current look-ahead direction.
var look_ahead_direction: Vector2 = Vector2.ZERO

## Cached smoothing weight.
var smoothing_weight: float = 0.0

## Final target position for the camera.
var target_position: Vector2 = Vector2.ZERO


## Initializes camera state and resolves the player reference.
func _ready() -> void:
	_update_smoothing_weight()

	if not player:
		player = get_tree().get_first_node_in_group("player")


## Updates camera position every frame.
func _process(_delta: float) -> void:
	update_position()


## Calculates and applies the camera position.
func update_position() -> void:
	if not player:
		push_warning("%s: no player to follow" % name)
		return

	target_position = apply_look_ahead(player.global_position)
	target_position = apply_smoothing(target_position)

	global_position = target_position.floor()


## Applies look-ahead offset to the target position.
func apply_look_ahead(target: Vector2) -> Vector2:
	if not look_ahead.enabled:
		return target

	_update_look_ahead_direction()
	return target + look_ahead_direction * look_ahead.look_ahead_distance


## Applies smoothing to the target position.
func apply_smoothing(target: Vector2) -> Vector2:
	if not smoothing.enabled:
		return target

	return lerp(global_position, target, smoothing.get_weight())


## Updates the look-ahead direction based on player movement.
func _update_look_ahead_direction() -> void:
	if not player:
		return

	if player.is_on_floor():
		_start_look_ahead_tween(player.movement.get_facing_direction())


## Starts a tween to smoothly transition the look-ahead direction.
func _start_look_ahead_tween(target_direction: Vector2) -> void:
	if tween and tween.is_running():
		return

	if target_direction.is_equal_approx(look_ahead_direction):
		return

	tween = create_tween()
	tween.tween_property(
		self,
		"look_ahead_direction",
		target_direction,
		look_ahead.reaction_time
	).set_ease(look_ahead.ease_type).set_trans(look_ahead.transition_type)

	tween.play()


## Updates the cached smoothing weight.
func _update_smoothing_weight() -> void:
	smoothing_weight = smoothing.get_weight()
