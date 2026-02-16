extends ProjectileState

var timer: float = 0.0
var is_charged: bool = false

func enter(_previous_state: String) -> void:
    super(_previous_state)
    is_charged = false
    timer = projectile.charge_time


func on_process(_delta: float) -> void:
    projectile.rotate_to_direction()


## Decrements the charge timer each frame. Emits the charged signal when timer reaches zero.
func advance_charge(delta: float) -> void:
    if is_charged:
        return
    timer -= delta
    if timer <= 0.0 and not is_charged:
        is_charged = true
        projectile.emit_charged()
