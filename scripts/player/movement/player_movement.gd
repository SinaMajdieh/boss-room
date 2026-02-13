extends BaseMovement
class_name PlayerMovement

@export_category("Components")
@export var player: Player


## Faces the player in the specified direction.
func face(direction: float) -> void:
    if is_zero_approx(direction):
        return
    if direction > 0 and facing_left:
        player.transform.x *= -1
        facing_left = false
        turn_around.emit()
    elif direction < 0 and not facing_left:
        player.transform.x *= -1
        facing_left = true
        turn_around.emit()


func is_moving() -> bool:
    return PlayerInput.get_direction() or not is_zero_approx(player.velocity.x)