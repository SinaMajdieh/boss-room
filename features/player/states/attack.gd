extends PlayerState

@export var attack_sequence: Array[Attack] = []
@onready var attack_animation_player: AnimationPlayer = player.attack_animation_player
@export var combo_timer: Timer

var attack: Attack
var combo: int = 0


# Initializes the attack state, handling combo continuation or reset
func enter(_previous_state: String) -> void:
	super(_previous_state)
	if not in_combo():
		reset_combo()
	else:
		combo_timer.stop()
	
	attack = attack_sequence[get_combo_index()]
	attack_animation_player.animation_finished.connect(_on_animation_finished)
	attack_animation_player.play(attack.animation_name)


# Applies gravity and deceleration, checks for dash input while attack is active
func on_physics_process(delta: float) -> void:
	player.movement.apply_gravity(delta)
	player.movement.decelerate(delta)
	if not attack.hurt_box.is_active():
		check_dash()


# Cleans up animation connections and progresses combo if attack connected
func exit() -> void:
	attack_animation_player.seek(attack_animation_player.get_section_end_time(), true)
	attack_animation_player.animation_finished.disconnect(_on_animation_finished)
	if attack.was_a_hit():
		next_combo()
		combo_timer.start()


# Transitions to idle state when animation completes
func _on_animation_finished(animation_name_: String) -> void:
	if animation_name_ == attack.animation_name:
		transition_to("idle")


# Returns the current attack index, clamped within sequence bounds
func get_combo_index() -> int:
	return clamp(combo, 0, attack_sequence.size() - 1)


# Advances to next combo attack, resets if sequence is exhausted
func next_combo() -> void:
	combo = clamp(combo + 1, 0, attack_sequence.size())
	if combo == attack_sequence.size():
		combo = 0
		return


# Checks if player is currently in an active combo window
func in_combo() -> bool:
	return not combo_timer.is_stopped()


# Resets combo counter to first attack in sequence
func reset_combo() -> void:
	combo = 0


# Resets combo when timer expires (combo window closed)
func _on_combo_timer_timeout() -> void:
	reset_combo()
