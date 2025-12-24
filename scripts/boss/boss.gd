extends CharacterBody2D

@export_category("Components")
@export var health: BossHealth

@export var gravity_down: float = 1400.0

func _ready() -> void:
	health.health_changed.connect(health_changed)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity_down * delta
	move_and_slide()

func health_changed(new_health: float) -> void:
	print("Now I only have %2.2f/%2.2f!" % [new_health, health.max_health])
