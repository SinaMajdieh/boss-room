extends PlayerShootState
## Manages the charge shot mechanic, allowing the player to charge bullets through stages.

@export_category("Components")
@export var player_bullet_scene: Array[PackedScene]

var bullet_instance: ChargeBullet
var charge_state_index: int = 0


func play_animation() -> void:
	if animations.is_animation_playing(resource.shoot_turn_animation):
		return

	if player.is_on_floor():
		if is_zero_approx(player.velocity.x):
			animations.play_animation(resource.shoot_animation[aim_direction])
			animations.set_frame_and_progress(0 ,0.0)
		else:
			play_shoot_animation(resource.shoot_run_animation)
	else:
		play_shoot_animation(resource.air_shoot_animation)


## Called when entering the charge shot state. Initializes the first charge stage.
func enter(_previous_state: String) -> void:
	super(_previous_state)
	charge_state_index = -1
	next_stage()


## Signal handler called when the current bullet completes a charge stage.
func _on_bullet_charged() -> void:
	if not bullet_instance:
		return
	next_stage()


## Advances to the next charge stage, instantiating the appropriate bullet scene.
## Creates the next stage bullet, connects its charged signal, and cleans up the previous one.
func next_stage() -> void:
	if charge_state_index < player_bullet_scene.size() - 1:
		charge_state_index += 1
		var new_bullet = player_bullet_scene[charge_state_index].instantiate() as ChargeBullet
		new_bullet.charged.connect(_on_bullet_charged)

		get_tree().current_scene.add_child(new_bullet)
		_free_bullet()
		bullet_instance = new_bullet
		update_bullet_position()


## Handles player movement and bullet charging input during the charge shot state.
func on_process(delta: float) -> void:
	play_animation()

	if weapon_changed():
		release_bullet()
		exit_shooting()
	
	if PlayerInput.is_shooting() and bullet_instance:
		bullet_instance.advance_charge(delta)
		update_bullet_position()
	elif PlayerInput.shot_released() and bullet_instance:
		release_bullet()
		exit_shooting()
	
	if player.can("jump"):
		player.movement.process_jump()

	if PlayerInput.just_dashed():
		release_bullet()
		transition_to("dash")

	player.movement.apply_movement(delta)


## Releases the charged bullet and initiates cooldown before transitioning to the appropriate state.
func release_bullet() -> void:
	if bullet_instance:
		bullet_instance.release()
		bullet_instance = null
	player.shoot_cool_down.start(resource.shoot_cool_down_time)


## Updates the bullet position and direction based on player input and facing direction.
func update_bullet_position() -> void:
	if not bullet_instance:
		return
	update_aim_direction()
	bullet_instance.position = player.range_attacks.get_bullet_spawn_point(aim_direction)
	bullet_instance.direction = bullet_direction
	bullet_instance.rotate_to_direction()


## Cleans up the bullet when exiting the charge shot state.
func exit() -> void:
	super()
	_free_bullet()


## Returns whether state transitions are allowed. Prevents transitions during cooldown.
func can_transition() -> bool:
	return player.shoot_cool_down.is_stopped()


## Frees the current bullet instance if it exists. Used for cleanup when exiting the state.
func _free_bullet() -> void:
	if bullet_instance:
		bullet_instance.queue_free()
		bullet_instance = null
