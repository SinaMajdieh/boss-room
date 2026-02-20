extends FirePattern
class_name ChargedFirePattern

## Fire pattern to use when spawning projectiles.
@export var spawn_pattern: FirePattern

var charge_timer: float = 0.0
var current_phase: PhaseData = null
var charging: bool = false


func set_gun(gun_: Gun) -> void:
    super(gun_)
    spawn_pattern.set_gun(gun_)


func start_firing() -> void:
    if not gun.cool_down_timer.is_stopped():
        return

    charging = true
    firing = true
    charge_timer = 0.0
    current_phase = null


func stop_firing() -> void:
    if not charging:
        return
    
    charging = false
    firing = false
    
    release_shot()

## Spawns a projectile from the gun.
func spawn_projectile() -> void:
    if not spawn_pattern:
        return

    spawn_pattern.spawn_projectile()


func update(delta: float) -> void:
    if not charging:
        return
    
    charge_timer += delta
    update_phase()


func update_phase() -> void:
    var selected: PhaseData = null

    for phase: PhaseData in data.phases:
        if charge_timer >= phase.charge_time:
            selected = phase
    
    if selected != current_phase:
        current_phase = selected
        update_charging_vfx()


func release_shot() -> void:
    if not current_phase:
        return

    spawn_pattern.data.projectile = current_phase.projectile
    spawn_projectile()
    gun.cool_down_timer.start(data.cool_down_time)
    
    play_muzzle_flash()
    await vfx.animation_finished
    stop_muzzle_flash()


func play_muzzle_flash() -> void:
    if not vfx or not current_phase:
        return
    
    if vfx.has_animation(current_phase.muzzle_vfx_name):
        vfx.show()
        vfx.play_animation(current_phase.muzzle_vfx_name)


func update_charging_vfx() -> void:
    if not vfx or not current_phase:
        return
    
    if vfx.has_animation(current_phase.charging_vfx_name):
        vfx.show()
        vfx.play_animation(current_phase.charging_vfx_name)