## Runtime gun instance handling firing logic and visuals.
extends Node2D
class_name Gun


## Emitted whenever the gun fires a projectile.
signal fired


## Visual effects sprite.
@export var vfx: AnimatedSprite

## Marker defining the projectile spawn position.
@export var muzzle: Marker2D

## Cooldown timer controlling fire rate.
@export var cool_down_timer: Timer

## Gun configuration data.
@export var data: GunData = GunData.new()


## Fire pattern instance created from gun data.
var fire_pattern: FirePattern

## Direction the gun is currently aiming.
var fire_direction: Vector2 = Vector2.ZERO:
	set = aim_at


func _ready() -> void:
	vfx.hide()
	vfx.sprite_frames = data.vfx_sprites

	fire_pattern = data.fire_pattern_script.new()
	fire_pattern.set_gun(self)


func _process(delta: float) -> void:
	fire_pattern.update(delta)


## Rotates the gun to aim in the given direction.
func aim_at(direction: Vector2) -> void:
	fire_direction = direction
	rotation = direction.angle()


## Begins firing according to the fire pattern.
func start_firing() -> void:
	fire_pattern.start_firing()


## Stops firing.
func stop_firing() -> void:
	fire_pattern.stop_firing()


## Checks if the gun is currently firing.
func is_firing() -> bool:
	return fire_pattern.is_firing()


## Spawns a projectile from the muzzle position.
func spawn_projectile(
	projectile: PackedScene,
	direction: Vector2 = fire_direction
) -> void:
	var bullet_instance := projectile.instantiate() as ProjectileBase
	if not bullet_instance:
		return

	bullet_instance.position = muzzle.global_position
	bullet_instance.direction = direction

	get_tree().current_scene.add_child(bullet_instance)
	fired.emit()
