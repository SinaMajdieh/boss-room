extends PlayerState

func enter(_previous_state: String) -> void:
    transition_to("fall")