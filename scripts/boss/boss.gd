extends CharacterBody2D
class_name Boss

@export_category("Components")
@export var health: BossHealth
@export var movement: BossMovement
@export var pivots: Pivots
@export var state_machine: StateMachine

@export var collision: CollisionShape2D

func _ready() -> void:
	health.health_changed.connect(health_changed)
	# movement.face(-1.0)

# func _process(_delta: float) -> void:
# 	if PlayerInput.just_jumped():
# 		state_machine.transition(state_machine.get_current_state(), "roll")
# 	if PlayerInput.just_dashed():
# 		state_machine.transition(state_machine.get_current_state(), "spin")

func _physics_process(_delta: float) -> void:
	move_and_slide()

func hurt(amount: Variant, _direction: Vector2, _knock_back: float = 0.0) -> void:
	health.hurt(amount)

func health_changed(new_health: float) -> void:
	print("Now I only have %2.2f/%2.2f!" % [new_health, health.max_health])

func set_anchor_to(anchor_name: String) -> void:
	pivots.set_anchor_to(self, pivots.get_pivot(anchor_name))

func get_state() -> String:
	return state_machine.get_current_state()

func is_collapsed() -> bool:
	var top_anchor: Pivot = pivots.get_pivot("top")
	var center_anchor: Pivot = pivots.get_pivot("center")
	var direction: Vector2 = abs(center_anchor.direction_to(top_anchor))
	return true if is_zero_approx(direction.y) and is_equal_approx(direction.x, 1) else false