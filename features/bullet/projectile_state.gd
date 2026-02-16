extends NodeState
class_name ProjectileState

@export var projectile: ProjectileBase
@export var animation_name: StringName

var animated_sprite: AnimatedSprite

func play_animation() -> void:
    if animated_sprite.has_animation(animation_name):
        animated_sprite.play_animation(animation_name)


func enter(_previous_state: String) -> void:
    animated_sprite = projectile.animation
    play_animation()