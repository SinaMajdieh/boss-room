## Base state for projectile state machine.
extends NodeState
class_name ProjectileState


## Projectile controlled by this state.
@export var projectile: ProjectileBase

## Animation played when this state is entered.
@export var animation_name: StringName


## Cached reference to the projectile's animated sprite.
var animated_sprite: AnimatedSprite


## Plays the state's animation if it exists.
func play_animation() -> void:
	if animated_sprite.has_animation(animation_name):
		animated_sprite.play_animation(animation_name)


## Initializes animation on state entry.
func enter(_previous_state: String) -> void:
	animated_sprite = projectile.animation
	play_animation()
