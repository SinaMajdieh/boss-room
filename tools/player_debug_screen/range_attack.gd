extends PlayerDebugLabel


func _process(_delta):
	if not player:
		return
	text = "Range Attack: %s" % player.range_attacks.get_attack_name()
