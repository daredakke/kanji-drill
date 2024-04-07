class_name MainMenu
extends Control


signal settings_button_pressed
signal quit_button_pressed

@onready var quiz_button: Button = %QuizButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton
# Setup controls
@onready var setup_panel: Panel = %SetupPanel
@onready var close_button: Button = %CloseButton
@onready var start_spin_box: SpinBox = %StartSpinBox
@onready var end_spin_box: SpinBox = %EndSpinBox
@onready var questions_spin_box: SpinBox = %QuestionsSpinBox
@onready var start_button: Button = %StartButton


func _ready() -> void:
	quiz_button.pressed.connect(setup_panel.show)
	close_button.pressed.connect(setup_panel.hide)
	settings_button.pressed.connect(_show_settings)
	quit_button.pressed.connect(_quit_game)


func _show_settings() -> void:
	settings_button_pressed.emit()


func _quit_game() -> void:
	quit_button_pressed.emit()
