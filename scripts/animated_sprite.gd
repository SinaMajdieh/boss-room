extends AnimatedSprite2D
class_name AnimatedSprite

@export var base: Node2D


func play_animation(name_: StringName = animation, speed: float = 1) -> void:
	offset_to_base(name_)
	play(name_, speed)


func has_animation(name_: StringName) -> bool:
	return sprite_frames.has_animation(name_)


func is_animation_playing(name_: StringName) -> bool:
	return animation == name_ and is_playing()


func offset_to_base(name_: StringName) -> void:
	if not base:
		return
	var frame_height: float = sprite_frames.get_frame_texture(name_, 0).get_height()
	offset.y = -frame_height * 0.5
	position.y = base.position.y
