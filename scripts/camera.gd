extends Camera2D
class_name PlayerCamera

const MIN_SMOOTHING_DISTANCE: int = 1
const MAX_SMOOTHING_DISTANCE: int = 100
const SMOOTHING_SCALE: int = 1000

@export_category("Follow Player")
@export var player: Player

@export_category("Camera Smoothing")
@export var smoothing: CameraSmoothing = CameraSmoothing.new()

@export_category("Look Ahead")
@export var look_ahead: CameraLookAhead = CameraLookAhead.new()

var tween: Tween
var look_ahead_direction: Vector2 = Vector2.ZERO
var smoothing_weight: float = 0.0
var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	_update_smoothing_weight()
	if not player:
		player = get_tree().get_first_node_in_group("player")


func _process(_delta: float) -> void:
	update_position()


func update_position() -> void:
	if not player:
		push_warning("%s: no player to follow" % name)
		return

	target_position = apply_look_ahead(player.global_position)
	target_position = apply_smoothing(target_position)
	
	global_position = target_position.floor()


func apply_look_ahead(target: Vector2) -> Vector2:
	if not look_ahead.enabled:
		return target
	_update_look_ahead_direction()
	return target + look_ahead_direction * look_ahead.look_ahead_distance


func apply_smoothing(target: Vector2) -> Vector2:
	if not smoothing.enabled:
		return target
	return lerp(global_position, target, smoothing.get_weight())


func _update_look_ahead_direction() -> void:
	if not player:
		return
	if player.is_on_floor():
		_start_look_ahead_tween(player.movement.get_facing_direction())


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


func _update_smoothing_weight() -> void:
	smoothing_weight = smoothing.get_weight()
