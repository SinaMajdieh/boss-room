extends NodeState
class_name PlayerState

@export_category("Components")
@export var player: Player
@export var animation_name: String = ""

var animations: AnimatedSprite


func play_animation() -> void:
	if animations.has_animation(animation_name):
		animations.play(animation_name)


func enter(_previous_state: String) -> void:
	animations = player.animations
	play_animation()


## Checks if the player is moving and on the floor, transitions to run state if true.
func check_movement_input() -> void:
	if PlayerInput.get_direction() != 0 and player.is_on_floor():
		transition_to("run")


## Checks if the player is falling, transitions to fall state if velocity is downward.
func check_falling() -> void:
	if not player.is_on_floor() and player.velocity.y > 0.0:
		transition_to("fall")


## Checks if jump input is active, transitions to jump state if jump timer is running.
func check_jump_input() -> void:
	if not player.jump_timer.is_stopped():
		transition_to("jump")


## Checks if dash input was triggered, transitions to dash state if true.
func check_dash() -> void:
	if PlayerInput.just_dashed():
		transition_to("dash")


## Checks if attack input was triggered, transitions to attack state if true.
func check_attack() -> void:
	if PlayerInput.just_attacked():
		transition_to("attack")


## Checks if shoot input is active and cooldown is ready, transitions to shoot state if true.
func check_shoot() -> void:
	if PlayerInput.is_shooting() and player.shoot_cool_down.is_stopped():
		transition_to(player.range_attacks.get_attack_name())
