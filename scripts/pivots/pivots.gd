extends Node2D
class_name Pivots

var pivots: Dictionary[String, Pivot] = {}

func _ready() -> void:
    init()

func init() -> void:    
    var pivot_id: int = 0
    for pivot in get_children():
        if not pivot is Pivot:
            continue
        pivots[pivot.name.to_lower()] = pivot
        pivot.set_id(pivot_id)
        pivot_id += 1
        
func get_pivot_by_id(id: int) -> Pivot:
    for pivot: Pivot in pivots.values():
        if pivot.get_id() == id:
            return pivot
    return null

func get_pivot(pivot_name: String) -> Pivot:
    return pivots.get(pivot_name)

func get_pivot_by_direction(origin_name: String, direction: Vector2) -> Pivot:
    var origin: Pivot = get_pivot(origin_name)
    if not origin:
        return null
    for pivot: Pivot in pivots.values():
        if pivot == origin:
            continue
        if direction.is_equal_approx(origin.direction_to(pivot)):
            return pivot
    return null

func get_pivot_by_angle(origin_name: String, angle: float) -> Pivot:
    var direction: Vector2 = angle_to_direction(angle)
    return get_pivot_by_direction(origin_name, direction)

func set_anchor_to(node: Node2D ,pivot: Pivot) -> void:
    var offset: Vector2 = pivot.global_position - node.global_position
    node.translate(offset)
    offset = -offset.rotated(-node.rotation)
    for child: Variant in node.get_children():
        if child is Node2D:
            child.translate(offset)

static func angle_to_direction(angle: float) -> Vector2:
    var radians: float = deg_to_rad(angle)
    var x: float = cos(radians)
    var y: float = sin(radians)
    return Vector2(x, y)