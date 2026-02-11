extends BaseScreen

signal resume_requested
signal main_menu_requested

@export var resume_button : Button
@export var menu_button : Button
@export var animator: BaseUIAnimator

var tween: Tween


func _ready():
	resume_button.pressed.connect(
		func() -> void:
			resume_requested.emit()
	)
	menu_button.pressed.connect(
		func(): main_menu_requested.emit()
	)


func show_screen() -> void:
	if animator:
		animator.animate_in(self)
		return
	show()


func hide_screen() -> void:
	if animator:
		animator.animate_out(self)
		return
	hide()
