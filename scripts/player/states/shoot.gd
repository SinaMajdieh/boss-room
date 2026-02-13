extends PlayerState
class_name PlayerShootState

enum VerticalState {
	UP, UP_DIAGONAL,
	STRAIGHT,
	DOWN, DOWN_DIAGONAL
}

@export var resource: ShootingResource = ShootingResource.new()

var bullet_direction: Vector2 = Vector2.ZERO
var aim_direction: VerticalState = VerticalState.STRAIGHT


func play_shoot_animation(animation: StringName, speed: float = 1.0) -> void:
	if animations.is_animation_playing(animation):
		return
	if animations.sprite_frames.has_animation(animation):
		animations.play_animation(animation, speed)


func play_animation() -> void:
	if animations.is_animation_playing(resource.shoot_turn_animation):
		return
	if player.is_on_floor():
		if is_zero_approx(player.velocity.x):
			play_shoot_animation(resource.shoot_animation[aim_direction], (1 / resource.shoot_cool_down_time))
		else:
			play_shoot_animation(resource.shoot_run_animation)
	else:
		play_shoot_animation(resource.air_shoot_animation)


func update_aim_direction() -> void:
	bullet_direction = PlayerInput.get_looking_direction(
		player.movement.get_facing_direction()
	)
	aim_direction = vertical_states(bullet_direction)


# Instantiates a bullet, positions it relative to the player,
# and transitions to the appropriate state
func enter(_previous_state: String) -> void:
	super(_previous_state)
	player.movement.turn_around.connect(_on_turn_around)
	player.shoot_cool_down.timeout.connect(_on_shoot_timeout)


func _on_shoot_timeout() -> void:
	exit_shooting()


# Transition based on player's grounded state
func exit_shooting() -> void:
	if player.is_on_floor():
		transition_to("idle")
	else:
		transition_to("fall_no_coyote")


func exit() -> void:
	player.movement.turn_around.disconnect(_on_turn_around)
	player.shoot_cool_down.timeout.disconnect(_on_shoot_timeout)


## Returns true when the shoot cooldown has finished, allowing state transitions.
func can_transition() -> bool:
	return player.shoot_cool_down.is_stopped()


func _on_turn_around() -> void:
	if not player.is_on_floor():
		return
	animations.play_animation(resource.shoot_turn_animation)
	await animations.animation_finished
	play_animation()


func weapon_changed() -> bool:
	return player.range_attacks.get_attack_name() != name.to_lower()


static func vertical_states(direction: Vector2) -> VerticalState:
	var sector: float = PI / 4.0
	var half_sector: float = sector / 2.0

	var angle: float = wrapf(direction.angle(), -PI, PI)

	if abs(angle) <= half_sector or abs(abs(angle) - PI) <= half_sector:
		return VerticalState.STRAIGHT
	
	if angle < 0:
		if abs(angle + PI / 2.0) <= half_sector:
			return VerticalState.UP
		return VerticalState.UP_DIAGONAL
	else:
		if abs(angle - PI / 2.0) <= half_sector:
			return VerticalState.DOWN
		return VerticalState.DOWN_DIAGONAL
