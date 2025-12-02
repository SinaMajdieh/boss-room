extends Label

var player: Player

func _ready() -> void:
    player = get_tree().get_nodes_in_group("player")[0]
    if not player:
        push_warning("[]Player Debug Menu: Player Velocity]: No player was found")
        return

func _process(_delta: float) -> void:
    text = "Velocity: x: %5.2f y: %5.2f" % [player.velocity.x, player.velocity.y]