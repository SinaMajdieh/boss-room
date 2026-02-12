extends AnimatedSprite2D
class_name AnimatedSprite

func has_animation(name_: String) -> bool:
    return sprite_frames.has_animation(name_)


func is_animation_playing(name_: StringName) -> bool:
    return animation == name_ and is_playing()