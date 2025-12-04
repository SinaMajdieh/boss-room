extends Label

func _ready() -> void:
    var player: Player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Player Health]: No player was found")
        return
    player.health.hearts_changed.connect(health_changed)
    health_changed(player.health.get_hearts_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func health_changed(new_health: int) -> void:
    text = "Hearts: %s" % new_health