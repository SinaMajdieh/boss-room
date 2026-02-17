extends Node
class_name PlayerGunAiming

# ==================================================
# CONFIGURATION
# ==================================================

## Maps vertical aim states to gun position markers.
@export var idle_markers: Dictionary[VerticalState.State, Marker2D]
@export var run_markers: Dictionary[VerticalState.State, Marker2D]
@export var air_markers: Dictionary[VerticalState.State, Marker2D]


## Reference to the owning player.
@export var player: Player

## Reference to the gun manager.
@export var gun_manager: GunManager


# ==================================================
# STATE
# ==================================================

## Current vertical aiming state.
var vertical_state: VerticalState.State = VerticalState.State.STRAIGHT


# ==================================================
# LIFECYCLE
# ==================================================

func _process(_delta: float) -> void:
    _update_aim()


# ==================================================
# AIMING LOGIC
# ==================================================

## Updates gun aim direction, vertical state,
## and moves the gun to the correct marker.
func _update_aim() -> void:
    var gun: Gun = gun_manager.get_gun()
    if gun == null:
        return

    var aim_direction: Vector2 = PlayerInput.get_looking_direction(
        player.movement.get_facing_direction()
    )

    gun.aim_at(aim_direction)

    vertical_state = VerticalState.to_vertical_state(aim_direction)
    _move_gun_to(player.get_state(), vertical_state)


## Moves the active gun to the marker associated
## with the given vertical aiming state.
func _move_gun_to(
    state: StringName,
    vertical_state_: VerticalState.State,
	index: int = gun_manager.gun_index
) -> void:
    var gun: Gun = gun_manager.get_gun(index)
    if not gun:
        return

    var marker: Marker2D = _get_marker_for_state(state, vertical_state_)

    if marker:
        gun.position = marker.position


## Returns the marker for the given state and vertical state.
func _get_marker_for_state(
    state: StringName, 
    vertical_state_: VerticalState.State
) -> Marker2D:
    match state:
        "idle":
            return idle_markers.get(vertical_state_)
        "run":
            return run_markers.get(vertical_state_)
        "jump":
            return air_markers.get(vertical_state_)
        "fall":
            return air_markers.get(vertical_state_)
    return null

# ==================================================
# PUBLIC API
# ==================================================

## Returns the current vertical aiming state.
func get_vertical_state() -> VerticalState.State:
    return vertical_state
