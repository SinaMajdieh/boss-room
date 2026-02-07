extends BossState

@export var attacks: Array[String] = ["roll", "spin"]

func enter(_previous_state: String) -> void:
    var chosen_attack: String = choose_attack()
    transition_to(chosen_attack)

func choose_attack() -> String:
    var random_index: int = randi_range(0, len(attacks) - 1)
    return attacks[random_index]