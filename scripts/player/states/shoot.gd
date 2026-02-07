extends PlayerState

@export_category("Components")
@export var player_bullet_scene: PackedScene

@export_category("Parameters")
@export var shoot_cool_down_time: float = 0.1


# Instantiates a bullet, positions it relative to the player,
# and transitions to the appropriate state
func enter(_previous_state: String) -> void:
	# Create bullet instance and configure its properties
	var bullet_instance: BaseBullet = player_bullet_scene.instantiate() as BaseBullet
	var shoot_direction: Vector2 = PlayerInput.get_looking_direction(
		player.movement.get_facing_direction()
	)
	bullet_instance.position = player.global_position + shoot_direction * 16.0
	bullet_instance.direction = shoot_direction

	# Add bullet to the scene
	get_tree().current_scene.add_child(bullet_instance)

	# Start cooldown to prevent rapid firing
	player.shoot_cool_down.start(shoot_cool_down_time)

	# Transition based on player's grounded state
	if player.is_on_floor():
		transition_to("idle")
	else:
		transition_to("fall_no_coyote")


# Handles player movement while in shoot state
func on_process(delta: float) -> void:
	player.movement.apply_movement(delta)


# Prevents state transitions until the cooldown timer expires
func can_transition() -> bool:
	return player.shoot_cool_down.is_stopped()
