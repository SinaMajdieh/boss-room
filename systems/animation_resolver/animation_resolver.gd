extends Node
class_name AnimationResolver

# ==========================
# CONFIGURATION
# ==========================

@export var animated_sprite: AnimatedSprite
@export var providers: Array[Node] # Nodes that expose `get_animation_request()`


# ==========================
# CURRENT STATE
# ==========================

var current_animation: StringName = ""
var current_priority: int = -999
var current_locked: bool = false
var current_frozen: bool = false
var current_looped: bool = false

var time_since_played: float = 0.0
var min_duration: float = 0.0


# ==========================
# LIFECYCLE
# ==========================

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _process(delta: float) -> void:
	time_since_played += delta
	_resolve()


# ==========================
# CORE RESOLUTION
# ==========================

## Queries all providers and selects the highest‑priority animation request.
func _resolve() -> void:
	var best_request: AnimationRequest = null

	for provider in providers:
		if not _is_valid_provider(provider):
			continue

		var provider_request : AnimationRequest = provider.get_animation_request()
		if not provider_request:
			continue

		if not best_request or provider_request.priority > best_request.priority:
			best_request = provider_request

	_apply(best_request)


## Checks whether a provider can participate in animation resolution.
func _is_valid_provider(provider: Node) -> bool:
	return provider and provider.has_method("get_animation_request")


# ==========================
# REQUEST APPLICATION
# ==========================

## Applies an animation request while respecting locks, priority,
## minimum duration, freezing, and resume rules.
func _apply(req: AnimationRequest) -> void:
	if not req:
		return

	# Locked animations can only be overridden by higher priority
	if current_locked and req.priority <= current_priority:
		return

	# Prevent early interruption
	if time_since_played < min_duration:
		return

	# Resume a previously frozen animation
	if req.resume and req.name == current_animation:
		animated_sprite.speed_scale = req.speed
		current_frozen = false
		return

	# Ignore identical requests
	if _is_same_request(req):
		return

	_play(req)


## Plays the requested animation and updates resolver state.
func _play(req: AnimationRequest) -> void:
	if not animated_sprite.has_animation(req.name):
		return

	current_animation = req.name
	current_priority = req.priority
	current_locked = req.lock
	current_frozen = req.freeze
	current_looped = req.looped
	min_duration = req.min_duration
	time_since_played = 0.0

	animated_sprite.play_animation(req.name)
	animated_sprite.speed_scale = req.speed

	if current_frozen:
		animated_sprite.stop()


## Checks whether the incoming request matches the current animation state.
func _is_same_request(req: AnimationRequest) -> bool:
	return (
		req.name == current_animation
		and req.freeze == current_frozen
		and is_equal_approx(req.speed, animated_sprite.speed_scale)
	)


# ==========================
# EVENTS
# ==========================

## Handles animation completion and looping behavior.
func _on_animation_finished() -> void:
	if current_looped:
		animated_sprite.play_animation(current_animation)
		return

	current_priority = -999
	current_locked = false
	min_duration = 0.0


# ==========================
# OPTIONAL EXTERNAL API
# ==========================

## Forces an animation request directly, bypassing providers.
## Still respects priority rules.
func request(animation: AnimationRequest) -> void:
	if not animation or animation.priority < current_priority:
		return

	_play(animation)
