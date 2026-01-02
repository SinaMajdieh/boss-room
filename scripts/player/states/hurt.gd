extends PlayerState

var damage: Variant = 1
var knock_back: float = 0.0

func set_attributes(damage_: Variant = 1, knock_back_: float = 0.0) -> void:
	damage = damage_
	knock_back = knock_back_

func enter(_previous_state: String) -> void:
	player.hurt_timer.start()
	player.movement.apply_knock_back(knock_back)
	player.health.hurt(damage)
	transition_to("idle")

func can_transition() -> bool:
	return player.can_take_damage()
