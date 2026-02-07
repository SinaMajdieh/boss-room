extends BossDebugLabel

func update_label() -> void:
    text = "State: %s" % boss.state_machine.get_current_state()