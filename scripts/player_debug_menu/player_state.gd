extends Label

func _ready() -> void:
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	if not player:
		push_warning("[]Player Debug Menu: Player State]: No player was found")
		return
	player.state_machine.state_changed.connect(state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_changed(new_state: String) -> void:
	text = "State: %s" % new_state
