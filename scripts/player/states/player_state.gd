extends NodeState
class_name PlayerState

@export_category("Components")
@export var player: Player

func check_movement_input() -> void:
	if PlayerInput.get_direction() != 0 and player.is_on_floor():
		transition_to("run")

func check_falling() -> void:
	if not player.is_on_floor() and player.velocity.y > 0.0:
		transition_to("fall")

func check_jump_input() -> void:
	if not player.jump_timer.is_stopped():
		transition_to("jump")

func check_dash() -> void:
	if PlayerInput.just_dashed():
		transition_to("dash")

func check_attack() -> void:
	if PlayerInput.just_attacked():
		transition_to("attack")

func check_shoot() -> void:
	if PlayerInput.is_shooting() and player.shoot_cool_down.is_stopped():
		transition_to("shoot")