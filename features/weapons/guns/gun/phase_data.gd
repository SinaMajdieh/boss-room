## Data describing a single charge phase of a weapon.
extends Resource
class_name PhaseData


## Projectile spawned when this phase is released.
@export var projectile: PackedScene

## Time required to reach this phase.
@export var charge_time: float = 1.0


@export_category("VFX")
## Charging animation name.
@export var charging_vfx_name: StringName = "charging"

## Muzzle flash animation name.
@export var muzzle_vfx_name: StringName = "muzzle-fx"
