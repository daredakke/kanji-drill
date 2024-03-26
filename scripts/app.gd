class_name App
extends Control


@onready var main_menu: MainMenu = %MainMenu
@onready var settings: Settings = %Settings


func _ready() -> void:
	main_menu.settings_button_pressed.connect(settings.show)
	main_menu.quit_button_pressed.connect(_quit_game)


func _quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
