extends PlayerDebugLabel


func state_changed(new_state: String) -> void:
	text = "State: %s" % new_state


func set_player(player_ : Player) -> void:
	super(player_)
	player.state_machine.state_changed.connect(state_changed)
