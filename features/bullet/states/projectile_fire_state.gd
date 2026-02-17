## Active projectile state responsible for movement and collision.
extends ProjectileState
class_name ProjectileFireState


## Connects collision signals and aligns projectile rotation.
func enter(_previous_state: String) -> void:
	super(_previous_state)

	projectile.area_entered.connect(on_hit)
	projectile.body_entered.connect(on_hit)
	projectile.rotate_to_direction()


## Updates projectile movement and lifetime.
func on_process(delta: float) -> void:
	_move_projectile(delta)
	_update_lifetime(delta)


## Moves the projectile forward based on its direction and speed.
func _move_projectile(delta: float) -> void:
	projectile.position += projectile.direction.normalized() * projectile.speed * delta


## Decreases lifetime and removes projectile if expired.
func _update_lifetime(delta: float) -> void:
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
