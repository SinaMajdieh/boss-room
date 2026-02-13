extends Resource
class_name ShootingResource

@export_category("Parameters")
@export var shoot_cool_down_time: float = 0.1

@export_category("Shooting Animations")
@export var shoot_animation: Dictionary[PlayerShootState.VerticalState, StringName] = {
    PlayerShootState.VerticalState.UP: "shoot_up",
    PlayerShootState.VerticalState.UP_DIAGONAL: "shoot_up_diagonal",
    PlayerShootState.VerticalState.STRAIGHT: "shoot_straight",
    PlayerShootState.VerticalState.DOWN_DIAGONAL: "shoot_down_diagonal",
    PlayerShootState.VerticalState.DOWN: "shoot_down",
}
@export var air_shoot_animation: StringName = "shoot_air"
@export var shoot_run_animation: StringName = "shoot_run"
@export var shoot_turn_animation: StringName = "shoot_turn"