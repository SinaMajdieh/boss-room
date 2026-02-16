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


func play_sequence(animation_names: Array[StringName], speed: float = 1) -> void:
	if animation_names.is_empty():
		return
	var animation_name: StringName = animation_names.pop_front()
	if not has_animation(animation_name):
		play_sequence(animation_names, speed)
		return
	play_animation(animation_name, speed)
	animation_finished.connect(func() -> void:
		play_sequence(animation_names, speed)
	)


func play_animation(name_: StringName = animation, speed: float = 1) -> void:
	play(name_, speed)
	align_frames()
	set_base()


func has_animation(name_: StringName) -> bool:
	return sprite_frames.has_animation(name_)


func is_animation_playing(name_: StringName) -> bool:
	return animation == name_ and is_playing()


## Set offsets based on alignment
func align_frames() -> void:
	align_frames_horizontally()
	align_frames_vertically()


## Set X offset based on horizontal alignment
func align_frames_horizontally(alignment_: Alignment = horizontal_alignment) -> void:
	var frame_width: float = 0.0
	var frame_texture: Texture2D = sprite_frames.get_frame_texture(animation, 0)
	if frame_texture:
		frame_width = frame_texture.get_width()
	
	match alignment_:
		Alignment.LEFT:
			offset.x = frame_width * 0.5
		Alignment.RIGHT:
			offset.x = -frame_width * 0.5
		Alignment.CENTER:
			offset.x = 0
		_:
			offset.x = 0


## Set Y offset based on vertical alignment
func align_frames_vertically(alignment_: Alignment = vertical_alignment) -> void:
	var frame_height: float = 0.0
	var frame_texture: Texture2D = sprite_frames.get_frame_texture(animation, 0)
	if frame_texture:
		frame_height = frame_texture.get_height()
	match alignment_:
		Alignment.TOP:
			offset.y = frame_height * 0.5
		Alignment.BOTTOM:
			offset.y = -frame_height * 0.5
		Alignment.CENTER:
			offset.y = 0
		_:
			offset.y = 0


func set_base(base_position: Vector2 = base.position if base else Vector2.ZERO) -> void:
	position = base_position
