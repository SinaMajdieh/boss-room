## Hitbox for boss attacks that can optionally allow player phase-through.
extends BaseHitBox

## Controls whether the player can pass through this hitbox without taking damage.
@export var player_phase_through: bool = false:
    set = set_player_phase_through
@export var damage_points: float = 1
@export var knock_back: float = 800.0


func _ready() -> void:
    set_player_phase_through(player_phase_through)


## Handles collision with player area. Applies damage and knockback if player is in range.
func _on_area_entered(area: Area2D) -> void:
    if not area or not area.is_in_group("player"):
        return
    if area.has_method("hurt"):
        area.hurt(damage_points, global_position, knock_back)


## Sets whether player can phase through this hitbox.
## Connects/disconnects the area_entered signal based on phase_through state.
func set_player_phase_through(can_phase: bool) -> void:
    player_phase_through = can_phase

    if not can_phase and not area_entered.is_connected(_on_area_entered):
        area_entered.connect(_on_area_entered)
    elif can_phase and area_entered.is_connected(_on_area_entered):
        area_entered.disconnect(_on_area_entered)