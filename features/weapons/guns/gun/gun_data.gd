## Data container describing a gun's behavior and visuals.
extends Resource
class_name GunData


## Script implementing the fire pattern logic.
@export var fire_pattern: FirePattern

## Time (seconds) between shots.
@export var cool_down_time: float = 1.0

## Sprite frames used for weapon VFX.
@export var vfx_sprites: SpriteFrames = SpriteFrames.new()


@export_group("Simple Gun")
## Projectile scene spawned when firing.
@export var projectile: PackedScene


@export_subgroup("VFX")
## Name of the muzzle flash animation.
@export var muzzle_vfx_name: StringName = "muzzle-fx"


@export_group("Charge Gun")
## Phases used for charge-based weapons.
@export var phases: Array[PhaseData] = []
