extends BossState

@export var attack_timer: Timer


func _ready() -> void:
	if attack_timer:
		attack_timer.timeout.connect(_on_attack_timer_timeout)


func enter(_previous_state: String) -> void:
	attack_timer.start()


func on_physics_process(delta: float) -> void:
	boss.movement.apply_movement(delta)


func _on_attack_timer_timeout() -> void:
	transition_to("attack")