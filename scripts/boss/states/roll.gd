extends BossState

@export_category("Collapse Animation")
@export var collapse_ease_type: Tween.EaseType
@export var collapse_transition_type: Tween.TransitionType
@export var collapse_duration: float = 2.5

@export_category("Stand Animation")
@export var stand_ease_type: Tween.EaseType
@export var stand_transition_type: Tween.TransitionType
@export var stand_duration: float = 1.0

@export_category("Attributes")
@export var direction: float = 1.0
@export var roll_count: int = 1

var rotation_offset: float = 90.0
var tween: Tween


func enter(_previous_state: String) -> void:
	boss.rotation_degrees = 0.0
	update_direction_towards_player()
	if boss.is_collapsed():
		transition_to("idle")   
	tween = create_tween()
	tween.finished.connect(_on_roll_finished)
	roll()


## Update Direction Towards Player
func update_direction_towards_player() -> void:
	var player: Player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	update_direction(boss.global_position.direction_to(player.global_position).x)


## Update Direction
func update_direction(new_direction: float = direction) -> void:
	direction = -1.0 if new_direction < 0 else 1.0


## Roll 
func roll() -> void:
	var bottom_anchor: Pivot = boss.pivots.get_pivot_by_direction("center", Vector2(0.0, 1.0))
	boss.set_anchor_to(bottom_anchor.name.to_lower())
	if tween.is_running():
		tween.stop()

	for i: int in range(1, roll_count * 4 + 1, 2):
			# Collapse
			tween.tween_callback(_set_bottom_anchor)
			tween.tween_property(boss, "rotation_degrees", boss.rotation_degrees + i * (rotation_offset * direction), collapse_duration).set_ease(collapse_ease_type).set_trans(collapse_transition_type)
			# Stand
			tween.tween_callback(_set_corner_anchor)
			tween.chain().tween_property(boss, "rotation_degrees", boss.rotation_degrees + (i + 1) * (rotation_offset * direction), stand_duration).set_ease(stand_ease_type).set_trans(stand_transition_type)
	tween.play()


## Set Bottom Anchor
func _set_bottom_anchor() -> void:
	var anchor: Pivot = boss.pivots.get_pivot_by_direction("center", Vector2(0.0, 1.0))
	boss.set_anchor_to(anchor.name.to_lower())


## Set Corner Anchor
func _set_corner_anchor() -> void:
	var anchor_direction: Vector2 = Vector2(1.0, 0.0) if direction >= 0 else Vector2(-1.0, 0.0)
	var anchor: Pivot = boss.pivots.get_pivot_by_direction("center", anchor_direction)
	boss.set_anchor_to(anchor.name.to_lower())


func _on_roll_finished() -> void:
	transition_to("idle")


func on_physics_process(delta: float) -> void:
	boss.movement.apply_movement(delta)


func exit() -> void:
	if tween:
		if tween.is_running():
			tween.kill()
