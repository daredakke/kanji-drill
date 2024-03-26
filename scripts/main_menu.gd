class_name MainMenu
extends Control


signal settings_button_pressed
signal quit_button_pressed

@onready var quiz_button: Button = %QuizButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	settings_button.pressed.connect(_show_settings)
	quit_button.pressed.connect(_quit_game)


func _show_settings() -> void:
	settings_button_pressed.emit()


func _quit_game() -> void:
	quit_button_pressed.emit()
