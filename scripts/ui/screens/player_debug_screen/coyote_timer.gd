extends PlayerDebugLabel
var coyote_timer: Timer = null


func _process(_delta: float) -> void:
    if not coyote_timer:
        return
    text = "Coyote Timer: %2.2f" % coyote_timer.time_left


func set_player(player_ : Player) -> void:
    super(player_)
    coyote_timer = player.coyote_timer
