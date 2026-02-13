extends PlayerDebugLabel

var attack_state: PlayerState


func _process(_delta: float) -> void:
	if not attack_state:
		return
	text = "Combo Index: %2d" % attack_state.get_combo_index()


func set_player(player_ : Player) -> void:
	super(player_)
	attack_state = player.state_machine.get_node_state("attack")
