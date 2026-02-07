extends Label
var combo_timer: Timer = null

func _ready() -> void:
    var player: Player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Combo Timer]: No player was found")
        return
    combo_timer = player.combo_timer

func _process(_delta: float) -> void:
    if not combo_timer:
        return
    text = "Combo Timer: %2.2f" % combo_timer.time_left