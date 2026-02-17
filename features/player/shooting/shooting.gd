extends Node
class_name PlayerShooting

# ==================================================
# CONFIGURATION
# ==================================================

## Reference to the owning player.
@export var player: Player

## Reference to the gun manager.
@export var gun_manager: GunManager


# ==================================================
# STATE
# ==================================================

## True while the player is actively shooting.
var shooting: bool = false


# ==================================================
# LIFECYCLE
# ==================================================

func _process(_delta: float) -> void:
	_handle_input()


# ==================================================
# INPUT
# ==================================================

## Handles shooting and gun‑cycling input.
func _handle_input() -> void:
	if PlayerInput.is_cycling_guns():
		stop_shooting()
		gun_manager.cycle_guns()

	if PlayerInput.is_shooting() and player.can_shoot():
		start_shooting()
	else:
		stop_shooting()


# ==================================================
# SHOOTING CONTROL
# ==================================================

## Starts firing the currently selected gun.
func start_shooting() -> void:
	var gun: Gun = gun_manager.get_gun()
	if gun == null or shooting:
		return

	gun.start_firing()
	shooting = gun.is_firing()


## Stops firing the currently selected gun.
func stop_shooting() -> void:
	var gun: Gun = gun_manager.get_gun()
	if gun == null or not shooting:
		return

	gun.stop_firing()
	shooting = gun.is_firing()


# ==================================================
# QUERY METHODS
# ==================================================

## Returns whether the player is currently shooting.
func is_shooting() -> bool:
	return shooting


## Returns true if the current gun is charging a shot.
func is_charging() -> bool:
	var gun: Gun = gun_manager.get_gun()
	if gun != null and gun.fire_pattern is ChargedFirePattern:
		return gun.fire_pattern.charging
	return false
