extends Node
class_name PlayerShootingAnimationProvider

# ==================================================
# CONFIGURATION
# ==================================================

## Shooting animation definitions.
@export var animations: ShootingAnimations = ShootingAnimations.new()

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
    if not shooting.is_shooting():
        return null

    var request: AnimationRequest = animations.get_request(
        player.get_state(),
        aiming.get_vertical_state()
    ).duplicate()

    if request == null:
        return null

    if player.state_machine.is_in_state("idle"):
        var gun: Gun = gun_manager.get_gun()
        if gun.fire_pattern is ChargedFirePattern:
            if shooting.is_charging():
                request.freeze = true
                request.resume = false
            else:
                request.freeze = false
                request.resume = true
        elif gun != null:
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
        animations.shoot_turn.get(aiming.get_vertical_state())
    )
