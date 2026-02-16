extends ProjectileBase
class_name ChargeBullet

## Emitted when the bullet has finished charging and is ready to be released.
signal charged()

@export var charge_time: float = 1.0


## Decrements the charge timer each frame. Emits the charged signal when timer reaches zero.
func advance_charge(delta: float) -> void:
	if state_machine.get_current_state() != "charge":
		return
	state_machine.get_node_state("charge").advance_charge(delta)


## Fires the bullet by enabling collision detection and setting shot flag to true.
## Call this after charging is complete to release the projectile.
func release() -> void:
	monitoring = true
	state_machine.transition(state_machine.get_current_state(),"spawn")


func emit_charged() -> void:
	charged.emit()