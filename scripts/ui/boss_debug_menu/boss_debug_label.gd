extends Label
class_name BossDebugLabel

@export var boss: Boss

func _ready() -> void:
    get_boss()

func _process(_delta: float) -> void:
    if not boss:
        push_warning("%s: Boss was not found" % name)
    update_label()

func update_label() -> void:
    pass

func get_boss() -> void:
    if get_tree().get_node_count_in_group("boss") <= 0:
        return
    boss = get_tree().get_nodes_in_group("boss")[0]