extends Label
var dash_cool_down: Timer = null

func _ready() -> void:
    var player: Player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Dash Cool Down]: No player was found")
        return
    dash_cool_down = player.get_node("Timers/DashCoolDown")

func _process(_delta: float) -> void:
    if not dash_cool_down:
        return
    text = "Dash Cool Down: %2.2f" % dash_cool_down.time_left