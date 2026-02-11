extends Node
class_name GameRoot

@export var level_root: Node
@export var screen_manager: ScreenManager

@export var tutorial_level: PackedScene

var Screen = screen_manager.Screen


func _ready() -> void:
    screen_manager.start_game_requested.connect(_on_start_game)
    screen_manager.resume_requested.connect(_on_resume)
    screen_manager.main_menu_requested.connect(_on_main_menu)
    screen_manager.show_start()


func _on_start_game() -> void:
    load_level(tutorial_level)


func _on_pause() -> void:
    get_tree().paused = true
    screen_manager.show(Screen.PAUSE)


func _on_resume() -> void:
    get_tree().paused = false
    screen_manager.hide_all()


func _on_main_menu() -> void:
    get_tree().paused = false
    unload_level()
    screen_manager.show_start()


func load_level(scene: PackedScene) -> void:
    if not level_root:
        push_error("%s: No level root found" % name)
    
    unload_level()
    
    var level: Node = scene.instantiate()
    level_root.add_child(level)

    screen_manager.hide_all()


func unload_level() -> void:
    for child: Node in level_root.get_children():
        child.queue_free()


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        if screen_manager.is_current_screen(Screen.PAUSE):
            _on_resume()
        else:
            _on_pause()
