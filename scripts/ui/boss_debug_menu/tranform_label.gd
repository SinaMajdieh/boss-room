extends BossDebugLabel

func update_label() -> void:
    text = "Transform: x (%2.2f %2.2f) y (%2.2f %2.2f) origin (%2.2f %2.2f)" % [boss.transform.x.x, boss.transform.x.y, boss.transform.y.x, boss.transform.y.y, boss.transform.origin.x, boss.transform.origin.y]
