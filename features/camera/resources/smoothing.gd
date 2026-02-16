extends Resource
class_name CameraSmoothing

const MIN_SMOOTHING_DISTANCE: int = 1
const MAX_SMOOTHING_DISTANCE: int = 100
const SMOOTHING_SCALE: int = 1000

@export var enabled: bool = true
@export_range(MIN_SMOOTHING_DISTANCE, MAX_SMOOTHING_DISTANCE) 
var smoothing_distance: int = 25

func get_weight() -> float:
    return float(smoothing_distance) / SMOOTHING_SCALE