extends PlayerDebugLabel
var combo_timer: Timer = null


func _process(_delta: float) -> void:
    if not combo_timer:
        return
    text = "Combo Timer: %2.2f" % combo_timer.time_left

func set_player(player_ : Player) -> void:
    super(player_)
    combo_timer = player.combo_timer
