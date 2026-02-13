extends PlayerShootState

@export_category("Components")
@export var bullet_scene: PackedScene


func enter(previous_state: String) -> void:
    super(previous_state)
    shoot()


func shoot() -> void:	
    update_aim_direction()
    # Create bullet instance and configure its properties
    var bullet_instance: BaseBullet = bullet_scene.instantiate() as BaseBullet

    bullet_instance.position = player.range_attacks.get_bullet_spawn_point(aim_direction)
    bullet_instance.direction = bullet_direction

    # Add bullet to the scene
    get_tree().current_scene.add_child(bullet_instance)

    # Start cooldown to prevent rapid firing
    player.shoot_cool_down.start(resource.shoot_cool_down_time)


# Handles player movement while in shoot state
func on_process(delta: float) -> void:
    play_animation()

    if weapon_changed():
        exit_shooting()

    if player.can("jump"):
        player.movement.process_jump()
    
    check_dash()

    player.movement.apply_movement(delta)

func _on_shoot_timeout() -> void:
    if PlayerInput.is_shooting():
        shoot()
    else:
        exit_shooting()
