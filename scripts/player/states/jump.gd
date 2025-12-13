extends PlayerState

func on_physics_process(delta: float) -> void:
    player.movement.apply_movement(delta)

func on_process(_delta: float) -> void:
    check_falling()
    check_dash()
    check_attack()

func enter(_previous_state: String) -> void:
    if debug:
        print_rich("[color=green]Entered %s State" % name)
    # Handle jump.
    player.movement.process_jump()

func can_transition() -> bool:
    return player.is_on_floor() or not player.coyote_timer.is_stopped()
