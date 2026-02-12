extends PlayerState

func enter(previous_state: String) -> void:
	super(previous_state)
	player.movement.turn_around.connect(_on_turn_around)


func on_physics_process(delta: float) -> void:
	player.movement.apply_movement(delta)


func on_process(_delta: float) -> void:
	check_falling()
	check_jump_input()
	check_dash()
	check_attack()
	check_shoot()
	if player.velocity.x == 0:
		transition_to("idle")


func can_transition() -> bool:
	return player.is_on_floor()


func _on_turn_around() -> void:
	animations.play("turn")
	await animations.animation_finished
	play_animation()


func exit() -> void:
	player.movement.turn_around.disconnect(_on_turn_around)
