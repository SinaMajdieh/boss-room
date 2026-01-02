extends BaseHealth
class_name BossHealth

func hurt(amount: Variant = 1) -> void:
    print("Got hurt %2.2f points!" % amount)
    current_health = clamp(current_health - amount, 0, max_health)
    if current_health <= 0:
        depleted()