## Base class for all gun fire patterns.
## Controls firing state, cooldown checks, and muzzle VFX handling.
extends RefCounted
class_name FirePattern


## Owning gun instance.
var gun: Gun

## Cached gun data.
var data: GunData

## Cached VFX sprite.
var vfx: AnimatedSprite


## Whether the fire pattern is currently active.
var firing: bool = false


## Assigns the owning gun and caches required references.
func set_gun(gun_: Gun) -> void:
	gun = gun_
	data = gun.data
	vfx = gun.vfx


## Called every frame by the owning gun.
## Subclasses should override this.
func update(_delta: float) -> void:
	if not firing:
		return
	if not gun.cool_down_timer.is_stopped():
		return


## Starts firing and enables muzzle VFX handling.
func start_firing() -> void:
	if firing:
		return

	firing = true
	vfx.animation_finished.connect(stop_muzzle_flash)


## Stops firing and clears muzzle VFX.
func stop_firing() -> void:
	if not firing:
		return

	firing = false
	stop_muzzle_flash()

	if vfx.animation_finished.is_connected(stop_muzzle_flash):
		vfx.animation_finished.disconnect(stop_muzzle_flash)


## Plays the muzzle flash animation if available.
func play_muzzle_flash() -> void:
	if not vfx:
		return
	if not vfx.has_animation(data.muzzle_vfx_name):
		return

	vfx.show()
	vfx.play_animation(data.muzzle_vfx_name)


## Stops and hides the muzzle flash.
func stop_muzzle_flash() -> void:
	if not vfx:
		return

	vfx.stop()
	vfx.hide()


## Checks if the fire pattern is currently firing.
func is_firing() -> bool:
	return firing