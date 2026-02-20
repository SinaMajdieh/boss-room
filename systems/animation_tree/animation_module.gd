extends Node
class_name AnimationModule

## Reference to the owning AnimationTreeBase
var tree: AnimationTreeBase


## Called by AnimationTreeBase during setup.
## Injects the tree dependency into the module.
func set_up(_tree: AnimationTreeBase) -> void:
	tree = _tree


## Called every physics frame by AnimationTreeBase.
## Override in child modules.
func update() -> void:
	pass
