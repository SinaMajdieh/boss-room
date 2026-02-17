extends PlayerDebugLabel

func _process(_delta):
	if not player:
		return
	text = "Gun: %s" % player.gun_manager.get_gun_name()
