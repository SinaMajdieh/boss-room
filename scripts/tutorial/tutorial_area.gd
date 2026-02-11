extends Area2D
class_name TutorialArea2D

@export var controller: TutorialController
@export var hint: TutorialHint

func _ready() -> void:
    await get_tree().process_frame
    controller = get_tree().get_first_node_in_group("tutorial_controller")
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)


func _on_body_entered(body: CharacterBody2D) -> void:
    if not body or not body.is_in_group("player"):
        return
    if not controller:
        push_error("%s: No Tutorial Controller was found" % name)
        return
    
    controller.show_hint(hint)


func _on_body_exited(body: CharacterBody2D) -> void:
    if not body or not body.is_in_group("player"):
        return
    if not controller:
        push_error("%s: No Tutorial Controller was found" % name)
        return

    controller.clear_hint(hint.id)  
