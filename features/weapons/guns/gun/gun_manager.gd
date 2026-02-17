## Manages available guns and handles weapon switching.
extends Node
class_name GunManager


## Node containing Gun children.
@export var guns_node: Node2D

## Index of the currently selected gun.
@export var gun_index: int = 0


## Loaded gun instances.
var guns: Array[Gun] = []


func _ready() -> void:
	load_guns()


## Cycles to the next available gun.
func cycle_guns() -> void:
	if guns.is_empty():
		return

	gun_index = (gun_index + 1) % guns.size()


## Returns the gun at the given index.
func get_gun(index: int = gun_index) -> Gun:
	return guns.get(index)


## Returns the lowercase name of the selected gun.
func get_gun_name(index: int = gun_index) -> String:
	var gun := get_gun(index)
	return gun.name.to_lower() if gun else "none"


## Loads all Gun children from the guns node.
func load_guns() -> void:
	guns.clear()

	if not guns_node:
		return

	for child: Node2D in guns_node.get_children():
		if child is Gun:
			guns.append(child)
