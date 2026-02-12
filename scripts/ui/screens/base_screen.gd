extends Control
class_name BaseScreen

signal show_finished()
signal hide_finished()


func show_screen_animated() -> void:
    show_screen()


func hide_screen_animated() -> void:
    hide_screen()


func show_screen() -> void:
    show()
    show_finished.emit()



func hide_screen() -> void:
    hide()
    hide_finished.emit()
