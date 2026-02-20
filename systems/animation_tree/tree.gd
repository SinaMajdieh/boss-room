extends AnimationTree
class_name AnimationTreeBase

# References
var animation_player: AnimationPlayer
var playback: AnimationNodeStateMachinePlayback

# Modules & cached data
var modules: Array[AnimationModule] = []
var animation_lengths: Dictionary = {}



# Lifecycle
func _ready() -> void:
	## Cache state machine playback
	playback = get("parameters/playback")
	animation_player = get_node(anim_player)

	## Cache animation lengths once (performance)
	_cache_animation_lengths()

	_initialize_modules()

	active = true


func _physics_process(_delta: float) -> void:
	for module: AnimationModule in modules:
		module.update()


# -------------------------------------------------------------------
# Animation data helpers
# -------------------------------------------------------------------

## Discover and initialize animation modules
func _initialize_modules() -> void:
	for child: Node in get_children():
		if not child is AnimationModule:
			continue
		child.set_up(self)
		modules.append(child)


## Caches all animation lengths to avoid runtime lookups.
func _cache_animation_lengths() -> void:
	for anim_name: StringName in animation_player.get_animation_list():
		animation_lengths[anim_name] = animation_player.get_animation(anim_name).length


## Returns cached animation length in seconds.
func get_animation_length(anim_name: StringName) -> float:
	if not animation_lengths.has(anim_name):
		push_error("Missing animation: %s" % anim_name)
		return 0.0
	return animation_lengths[anim_name]


# -------------------------------------------------------------------
# AnimationTree helpers
# -------------------------------------------------------------------

## Sets a parameter value on the AnimationTree.
func set_param(path: String, value) -> void:
	set(path, value)


## Travels the AnimationNodeStateMachine to a state.
func travel(state_name: StringName) -> void:
	playback.travel(state_name)


## Fires an AnimationNodeOneShot at the given path.
func fire_one_shot(path: String) -> void:
	set(
		"%s/request" % path,
		AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE
	)


## Calculates a time scale so an animation fits a desired duration.
func calculate_time_scale(length: float, duration: float) -> float:
	if length <= 0.0 or duration <= 0.0:
		return 1.0
	return length / duration
