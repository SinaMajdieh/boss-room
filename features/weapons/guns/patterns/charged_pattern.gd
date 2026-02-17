extends FirePattern
class_name ChargedFirePattern

var charge_timer: float = 0.0
var current_phase: PhaseData = null
var charging: bool = false


func start_firing() -> void:
    if not gun.cool_down_timer.is_stopped():
        return

    charging = true
    is_firing = true
    charge_timer = 0.0
    current_phase = null


func stop_firing() -> void:
    if not charging:
        return
    
    charging = false
    is_firing = false
    
    release_shot()


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
    
    gun.spawn_projectile(current_phase.projectile)
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