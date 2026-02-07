extends BaseBullet
class_name ChargeBullet

## Emitted when the bullet has finished charging and is ready to be released.
signal charged()

@export var charge_time: float = 1.0

var timer: float = 0.0
var is_charged: bool = false
var shot: bool = false


func _ready() -> void:
    timer = charge_time


## Decrements the charge timer each frame. Emits the charged signal when timer reaches zero.
func advance_charge(delta: float) -> void:
    if is_charged:
        return
    timer -= delta
    if timer <= 0.0 and not is_charged:
        is_charged = true
        charged.emit()


## Fires the bullet by enabling collision detection and setting shot flag to true.
## Call this after charging is complete to release the projectile.
func release() -> void:
    shot = true
    area_entered.connect(on_hit)


## Moves the bullet along its direction vector and removes it when life_time expires.
func _process(delta: float) -> void:
    if shot:
        position += direction.normalized() * speed * delta
        life_time -= delta
        if life_time <= 0.0:
            queue_free()
