extends Node
class_name PlayerCollisionController

enum State {DEFAULT, DASH, DEAD}

@export var collisions: Dictionary[State, CollisionShape2D]
@export var hit_boxes: Dictionary [State, BaseHitBox]
@export var current_state : State = State.DEFAULT

func switch(state: State) -> void:
    _switch_collision(state)
    _switch_hit_box(state)
    current_state = state

func _switch_collision(state: State) -> void:
    var new_collision: CollisionShape2D = collisions.get(state)
    var current_collision: CollisionShape2D = collisions.get(current_state)
    if not new_collision or current_state == state:
        return
    if current_collision:
        _disable_collision(current_collision)
    _enable_collision(new_collision)

func _switch_hit_box(state: State) -> void:
    var new_hit_box: BaseHitBox = hit_boxes.get(state)
    var current_hit_box: BaseHitBox = hit_boxes.get(current_state)
    if not new_hit_box or current_state == state:
        return
    if current_hit_box:
        current_hit_box.disable()
    new_hit_box.enable()

func _disable_collision(collision: CollisionShape2D) -> void:
    collision.disabled = true
    collision.visible = false

func _enable_collision(collision: CollisionShape2D) -> void:
    collision.disabled = false
    collision.visible = true
