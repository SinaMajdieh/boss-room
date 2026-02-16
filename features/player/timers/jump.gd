extends Timer

func _process(_delta) -> void:
    if PlayerInput.just_jumped() and is_stopped():
        start()