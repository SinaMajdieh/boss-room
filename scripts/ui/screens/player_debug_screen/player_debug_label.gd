extends Label
class_name PlayerDebugLabel

var player: Player

func _ready() -> void:
	var parent: Node = get_parent().get_parent()
	if parent is PlayerDebugScreen: 
		player = parent.player

func set_player(player_ : Player) -> void:
	if not player_:
		return
	player = player_
