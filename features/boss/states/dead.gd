extends BossState

func enter(_previous_state: String) -> void:
    boss.queue_free()