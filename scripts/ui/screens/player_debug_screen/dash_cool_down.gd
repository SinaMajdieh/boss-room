extends PlayerDebugLabel
var dash_cool_down: Timer = null


func _process(_delta: float) -> void:
    if not dash_cool_down:
        return
    text = "Dash Cool Down: %2.2f" % dash_cool_down.time_left


func set_player(player_ : Player) -> void:
    super(player_)
    dash_cool_down = player.get_node("Timers/DashCoolDown")
