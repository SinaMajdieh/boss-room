## Animated sprite with alignment and sequencing helpers.
extends AnimatedSprite2D
class_name AnimatedSprite


enum Alignment {
	CENTER,
	LEFT,
	RIGHT,
	TOP,
	BOTTOM
}


@export var horizontal_alignment: Alignment = Alignment.CENTER
@export var vertical_alignment: Alignment = Alignment.CENTER
@export var base: Node2D


## Cached callable for sequence playback to avoid signal leaks.
var _sequence_callable: Callable


## Plays a sequence of animations in order.
func play_sequence(animation_names: Array[StringName], speed: float = 1.0) -> void:
	if animation_names.is_empty():
		return

	var remaining := animation_names.duplicate()
	_play_next_in_sequence(remaining, speed)


func _play_next_in_sequence(animation_names: Array[StringName], speed: float) -> void:
	if animation_names.is_empty():
		return

	var animation_name: StringName = animation_names.pop_front()
	if not has_animation(animation_name):
		_play_next_in_sequence(animation_names, speed)
		return

	play_animation(animation_name, speed)

	if _sequence_callable and animation_finished.is_connected(_sequence_callable):
		animation_finished.disconnect(_sequence_callable)

	_sequence_callable = func() -> void:
		_play_next_in_sequence(animation_names, speed)

	animation_finished.connect(_sequence_callable)


## Plays a single animation and applies alignment.
func play_animation(name_: StringName = animation, speed: float = 1.0) -> void:
	play(name_, speed)
	align_frames()
	set_base()


func has_animation(name_: StringName) -> bool:
	return sprite_frames.has_animation(name_)


func is_animation_playing(name_: StringName) -> bool:
	return animation == name_ and is_playing()


## Aligns frames based on configured alignment.
func align_frames() -> void:
	align_frames_horizontally()
	align_frames_vertically()


## Aligns frames horizontally.
func align_frames_horizontally(alignment_: Alignment = horizontal_alignment) -> void:
	var frame_width := 0.0
	var frame_texture := sprite_frames.get_frame_texture(animation, 0)

	if frame_texture:
		frame_width = frame_texture.get_width()

	match alignment_:
		Alignment.LEFT:
			offset.x = frame_width * 0.5
		Alignment.RIGHT:
			offset.x = -frame_width * 0.5
		_:
			offset.x = 0.0


## Aligns frames vertically.
func align_frames_vertically(alignment_: Alignment = vertical_alignment) -> void:
	var frame_height := 0.0
	var frame_texture := sprite_frames.get_frame_texture(animation, 0)

	if frame_texture:
		frame_height = frame_texture.get_height()

	match alignment_:
		Alignment.TOP:
			offset.y = frame_height * 0.5
		Alignment.BOTTOM:
			offset.y = -frame_height * 0.5
		_:
			offset.y = 0.0


## Sets sprite position based on base node.
func set_base(base_position: Vector2 = base.position if base else Vector2.ZERO) -> void:
	position = base_position


## Returns the duration of an animation in seconds.
func get_animation_duration(name_: StringName) -> float:
	if not has_animation(name_):
		return 0.0

	var fps := sprite_frames.get_animation_speed(name_)
	var frame_count := sprite_frames.get_frame_count(name_)
	return float(frame_count) / fps
