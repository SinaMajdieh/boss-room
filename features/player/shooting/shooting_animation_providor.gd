extends Node
class_name PlayerShootingAnimationProvider

# ==================================================
# CONFIGURATION
# ==================================================

## Shooting animation definitions.
@export var shooting_animations: ShootingAnimations = ShootingAnimations.new()
@export var charging_animations: ShootingAnimations = ShootingAnimations.new()

## Reference to the owning player.
@export var player: Player

## Reference to the gun manager.
@export var gun_manager: GunManager

## Reference to the shooting gameplay component.
@export var shooting: PlayerShooting

## Reference to the aiming component.
@export var aiming: PlayerGunAiming


# ==================================================
# LIFECYCLE
# ==================================================

func _ready() -> void:
	player.movement.turn_around.connect(_on_turn)


# ==================================================
# ANIMATION PROVIDER
# ==================================================

## Provides an AnimationRequest for the AnimationResolver.
func get_animation_request() -> AnimationRequest:
	var request: AnimationRequest = _get_charging_animation_request()
	if not request:
		request = _get_shooting_animation_request()
	return request


## Provides an AnimationRequest for the charged shooting.
func _get_charging_animation_request() -> AnimationRequest:
	if not shooting.is_charging() or not shooting.is_shooting():
		return null
	var request: AnimationRequest = charging_animations.get_request(
		player.get_state(),
		aiming.get_vertical_state()
	)
	return request


## Provides an AnimationRequest for the normal shooting.
func _get_shooting_animation_request() -> AnimationRequest:
	if not shooting.is_shooting():
		return null

	var request: AnimationRequest = shooting_animations.get_request(
		player.get_state(),
		aiming.get_vertical_state()
	)

	if not request:
		return null

	if player.state_machine.is_in_state("idle"):
		var gun: Gun = gun_manager.get_gun()
		if gun:
			request.speed = 1.0 / gun.data.cool_down_time

	return request


# ==================================================
# EVENTS
# ==================================================

## Handles shoot‑turn animation when the player flips direction mid‑run.
func _on_turn() -> void:
	if not shooting.is_shooting():
		return

	if not player.state_machine.is_in_state("run"):
		return

	player.animation_resolver.request(
		shooting_animations.shoot_turn.get(aiming.get_vertical_state())
	)
