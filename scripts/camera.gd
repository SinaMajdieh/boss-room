extends Camera2D
class_name PlayerCamera

const MIN_SMOOTHING_DISTANCE: int = 1
const MAX_SMOOTHING_DISTANCE: int = 100
const SMOOTHING_SCALE: int = 1000

@export_category("Follow PLayer")
@export var player: Player

@export_category("Camera Smoothing")
@export var smoothing_enabled: bool = true
@export_range(MIN_SMOOTHING_DISTANCE, MAX_SMOOTHING_DISTANCE) 
var smoothing_distance: int = 3

@export_category("Look Ahead")
@export var look_ahead_enabled: bool = true
@export var look_ahead_distance: float = 50.0

var smoothing_weight: float
var target_position: Vector2


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

    target_position = apply_look_ahead_if_enabled(player.global_position)
    target_position = apply_smoothing_if_enabled(target_position)
    
    global_position = target_position.floor()


func apply_look_ahead_if_enabled(target: Vector2) -> Vector2:
    if not look_ahead_enabled:
        return target
    return target + player.movement.get_facing_direction() * look_ahead_distance


func apply_smoothing_if_enabled(target: Vector2) -> Vector2:
    if not smoothing_enabled:
        return target
    return lerp(global_position, target, smoothing_weight)

func _update_smoothing_weight() -> void:
    smoothing_weight = float(smoothing_distance) / SMOOTHING_SCALE