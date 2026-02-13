extends PlayerDebugLabel
var jump_timer: Timer = null


func _process(_delta: float) -> void:
	if not jump_timer:
		return
	text = "Jump Timer: %2.2f" % jump_timer.time_left


func set_player(player_ : Player) -> void:
	super(player_)
	jump_timer = player.jump_timer
