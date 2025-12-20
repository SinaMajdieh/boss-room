extends PlayerState

@export var attack_sequence: Array[Attack] = []
@onready var attack_animation_player: AnimationPlayer = player.attack_animation_player
@export var combo_timer: Timer

var attack: Attack
var combo: int = 0

func enter(_previous_state: String) -> void:
	combo_timer.stop()
	attack = attack_sequence[get_combo_index()]
	attack_animation_player.animation_finished.connect(_on_animation_finished)
	attack_animation_player.play(attack.animation_name)

func on_physics_process(delta: float) -> void:
	player.movement.apply_gravity(delta)
	player.movement.decelerate(delta)
	if not attack.hurt_box.is_active():
		check_dash()

func exit() -> void:
	attack_animation_player.seek(attack_animation_player.get_section_end_time(), true)
	attack_animation_player.animation_finished.disconnect(_on_animation_finished)
	if attack.was_a_hit():
		next_combo()
		combo_timer.start()


func _on_animation_finished(animation_name: String) -> void:
	if animation_name == attack.animation_name:
		transition_to("idle")

func get_combo_index() -> int:
	return clamp(combo, 0, attack_sequence.size() - 1)

func next_combo() -> void:
	combo = clamp(combo + 1, 0, attack_sequence.size())
	if combo == attack_sequence.size():
		combo = 0
		return

func reset_combo() -> void:
	combo = 0

func _on_combo_timer_timeout() -> void:
	reset_combo()
