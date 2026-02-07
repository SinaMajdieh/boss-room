extends BossDebugLabel

func update_label() -> void:
    text = "Rotation: %3.0f" % boss.rotation_degrees
