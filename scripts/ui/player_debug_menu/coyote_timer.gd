extends Label
var coyote_timer: Timer = null

func _ready() -> void:
    var player: Player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Coyote Timer]: No player was found")
        return
    coyote_timer = player.coyote_timer

func _process(_delta: float) -> void:
    if not coyote_timer:
        return
    text = "Coyote Timer: %2.2f" % coyote_timer.time_left