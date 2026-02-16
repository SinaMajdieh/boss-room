extends ProjectileState

func enter(_previous_state: String) -> void:
    animated_sprite = projectile.animation
    if animated_sprite.has_animation(animation_name):
        animated_sprite.play_animation(animation_name)
        animated_sprite.animation_finished.connect(projectile.queue_free)
    else:
        projectile.queue_free()
