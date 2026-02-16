extends Node
class_name ScreenManager


@export var screens: Dictionary[Screen, BaseScreen]
@export var current_screen: Screen = Screen.NONE

enum Screen{
	NONE,
	START,
	PAUSE,
	DEATH
}


# ? Might be useful later
# func show(screen: Screen) -> void:
# 	if current_screen == screen:
# 		return
# 	hide_all()
# 	current_screen = screen

# 	if screen == Screen.NONE:
# 		return
	
# 	var screen_node: BaseScreen = screens.get(screen)
# 	if screen_node:
# 		screen_node.show_screen_animated()


func hide_all() -> void:
	for screen: BaseScreen in screens.values():
		screen.hide_screen()
	current_screen = Screen.NONE


func get_screen(screen: Screen) -> BaseScreen:
	return screens.get(screen)


func is_current_screen(screen: Screen) -> bool:
	return screen == current_screen
