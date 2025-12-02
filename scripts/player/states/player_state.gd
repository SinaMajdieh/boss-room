extends NodeState
class_name PlayerState

@export_category("Components")
@export var player: Player

func check_movement_input() -> void:
	if PlayerInput.get_direction() != 0 and player.is_on_floor():
		transition.emit("run")

func check_falling() -> void:
	if not player.is_on_floor() and player.velocity.y > 0.0:
		transition.emit("fall")

func check_jump_input() -> void:
	if not player.jump_timer.is_stopped():
		transition.emit("jump")
