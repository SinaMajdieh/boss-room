extends PlayerDebugLabel


func health_changed(new_health: int) -> void:
	text = "Hearts: %s" % new_health


func set_player(player_ : Player) -> void:
	super(player_)
	player.health.health_changed.connect(health_changed)
	health_changed(player.health.get_health())
