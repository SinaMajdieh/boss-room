extends Node
class_name Attack

@export var animation_name: String
@export var hurt_box: HurtBox

func was_a_hit() -> bool:
    return hurt_box.was_a_hit()