extends ProjectileState

func enter(_previous_state: String) -> void:
    animated_sprite = projectile.animation
    if animated_sprite.has_animation(animation_name):
        animated_sprite.play_animation(animation_name)
        animated_sprite.animation_finished.connect(_on_spawn_animation_finished)
    else:
        _on_spawn_animation_finished()


func _on_spawn_animation_finished() -> void:
    transition_to("fire")