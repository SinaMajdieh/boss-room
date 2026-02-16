extends ProjectileState
class_name BaseBulletFireState

func enter(_previous_state: String) -> void:
	super(_previous_state)
	projectile.area_entered.connect(on_hit)
	projectile.body_entered.connect(on_hit)
	projectile.rotate_to_direction()


func on_process(delta: float) -> void:
	projectile.position += projectile.direction.normalized() * projectile.speed * delta
	projectile.life_time -= delta
	if projectile.life_time <= 0.0:
		projectile.queue_free()


## Handles collision with targets and applies damage.
func on_hit(target: Variant) -> void:
	if not target:
		return
	if target.has_method("hurt"):
		target.hurt(projectile.damage)
	
	transition_to("death")
