extends BossState

@export_category("Attributes")
@export var initial_rotation_speed: float = 360.0 * 0.25
@export var final_rotation_speed: float = 360.0 * 5
@export var initial_speed: float = 300.0
@export var direction: float = 1.0
@export var spin_duration: float = 5.0

var tween: Tween
var rotation_speed: float = 0.0
var speed: float = 0.0

var target: CharacterBody2D


func enter(_previous_state: String) -> void:
	target = get_tree().get_first_node_in_group("player")
	boss.set_anchor_to("center")
	tween = create_tween()
	tween.finished.connect(_on_spin_finished)
	tween.tween_property(boss, "global_position", boss.global_position + Vector2(0, -50), 1.0)
	tween.tween_callback(spin)
	tween.chain().tween_property(self, "rotation_speed", final_rotation_speed, spin_duration * 0.5)
	tween.parallel().tween_property(self, "speed", initial_speed, spin_duration * 0.5)
	tween.chain().tween_property(self, "rotation_speed", 0.0, spin_duration * 0.5)
	tween.parallel().tween_property(self, "speed", 0, spin_duration * 0.5)
	tween.chain().tween_property(boss, "rotation_degrees", 0.0, 0.5)
	tween.play()


func spin() -> void:
	rotation_speed = initial_rotation_speed


func on_process(delta: float) -> void:
	boss.rotation_degrees += direction * rotation_speed * delta


func on_physics_process(_delta: float) -> void:
	if target:
		var target_position: Vector2 = target.global_position
		var speed_direction: Vector2 = boss.global_position.direction_to(target_position)
		boss.velocity = speed_direction * speed


func _on_spin_finished() -> void:
	transition_to("idle") 


func exit() -> void:
	rotation_speed = 0.0
	boss.velocity = Vector2.ZERO
	if tween:
		if tween.is_running():
			tween.kill()