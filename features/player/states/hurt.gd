extends PlayerState

var damage: Variant = 1
var knock_back: Vector2 = Vector2.ZERO


## Sets the damage and knockback values for the hurt state.
func set_attributes(damage_: Variant = 1, knock_back_: Vector2 = Vector2.ZERO) -> void:
	damage = damage_
	knock_back = knock_back_


## Enters the hurt state and applies damage and knockback.
func enter(_previous_state: String) -> void:
	player.hurt_timer.start()
	player.movement.apply_knock_back(knock_back)
	player.health.hurt(damage)
	transition_to("idle")


## Checks if the player can transition out of the hurt state.
func can_transition() -> bool:
	return player.can_take_damage()
