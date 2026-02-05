extends PlayerState

@export_category("Components")
@export var player_bullet_scene: PackedScene

@export_category("Parameters")
@export var shoot_cool_down_time: float = 0.1

func enter(_previous_state: String) -> void:
    var bullet_instance: BaseBullet = player_bullet_scene.instantiate() as BaseBullet
    var shoot_direction: Vector2 = player.movement.get_facing_direction()
    bullet_instance.position = player.global_position + shoot_direction * 16.0
    bullet_instance.direction = shoot_direction
    get_tree().current_scene.add_child(bullet_instance)
    
    player.shoot_cool_down.start(shoot_cool_down_time)
    
    if player.is_on_floor():
        transition_to("idle")
    else:
        transition_to("fall_no_coyote")

func on_process(delta: float) -> void:
    player.movement.apply_movement(delta)

func can_transition() -> bool:
    return player.shoot_cool_down.is_stopped()
