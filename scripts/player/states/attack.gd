extends PlayerState

@export var attack_animation_name: String
@export var hurt_box: HurtBox
@onready var attack_animation_player: AnimationPlayer = player.attack_animation_player


func enter(_previous_state: String) -> void:
	attack_animation_player.animation_finished.connect(_on_animation_finished)
	attack_animation_player.play(attack_animation_name)

func on_physics_process(delta: float) -> void:
	player.movement.apply_gravity(delta)
	player.movement.decelerate(delta)
	if not hurt_box.is_active():
		check_dash()

func exit() -> void:
	attack_animation_player.seek(attack_animation_player.get_section_end_time(), true)
	attack_animation_player.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(animation_name: String) -> void:
	if animation_name == attack_animation_name:
		transition_to("idle")
