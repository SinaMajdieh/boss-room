extends Label
var jump_timer: Timer = null

func _ready() -> void:
    var player: Player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Jump Timer]: No player was found")
        return
    jump_timer = player.jump_timer

func _process(_delta: float) -> void:
    if not jump_timer:
        return
    text = "Jump Timer: %2.2f" % jump_timer.time_left