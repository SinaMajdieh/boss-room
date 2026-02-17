## Resource defining positional smoothing behavior for the camera.
extends Resource
class_name CameraSmoothing


## Minimum allowed smoothing distance.
const MIN_SMOOTHING_DISTANCE: int = 1

## Maximum allowed smoothing distance.
const MAX_SMOOTHING_DISTANCE: int = 100

## Scale used to convert smoothing distance into a lerp weight.
const SMOOTHING_SCALE: int = 1000


## Enables or disables camera smoothing.
@export var enabled: bool = true

## Distance used to calculate smoothing weight.
@export_range(MIN_SMOOTHING_DISTANCE, MAX_SMOOTHING_DISTANCE)
var smoothing_distance: int = 25


## Returns the lerp weight derived from the smoothing distance.
func get_weight() -> float:
	return float(smoothing_distance) / SMOOTHING_SCALE
