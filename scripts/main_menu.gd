class_name MainMenu
extends Control


signal quiz_started
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
# Error popup
@onready var error_margin: MarginContainer = %ErrorMargin
@onready var close_error_button: Button = %CloseErrorButton


func _ready() -> void:
	setup_panel.hide()
	error_margin.hide()
	show()
	focus_menu()
	
	quiz_button.pressed.connect(_show_setup_panel)
	close_button.pressed.connect(_hide_setup_panel)
	settings_button.pressed.connect(_show_settings)
	quit_button.pressed.connect(_quit_game)
	
	start_spin_box.value_changed.connect(_on_start_spinbox_value_changed)
	end_spin_box.value_changed.connect(_on_end_spinbox_value_changed)
	questions_spin_box.value_changed.connect(_on_questions_spinbox_value_changed)
	start_button.pressed.connect(_on_start_button_pressed)
	
	close_error_button.pressed.connect(_on_close_error_message)


func focus_menu() -> void:
	_enable_main_menu()
	quiz_button.grab_focus()


func _show_settings() -> void:
	settings_button_pressed.emit()
	_disable_main_menu()


func _quit_game() -> void:
	quit_button_pressed.emit()


func _show_setup_panel() -> void:
	setup_panel.show()
	_disable_main_menu()
	start_button.grab_focus()


func _hide_setup_panel() -> void:
	setup_panel.hide()
	focus_menu()


func _on_start_spinbox_value_changed(value: int) -> void:
	State.start = clampi(value, 1, 2200)


func _on_end_spinbox_value_changed(value: int) -> void:
	State.end = clampi(value, 1, 2200)


func _on_questions_spinbox_value_changed(value: int) -> void:
	State.questions = clampi(value, 1, 2200)


func _on_start_button_pressed() -> void:
	if not State.valid_setup_values():
		error_margin.show()
		close_error_button.grab_focus()
		return
	
	setup_panel.hide()
	quiz_started.emit()


func _on_close_error_message() -> void:
	error_margin.hide()
	start_button.grab_focus()


func _disable_main_menu() -> void:
	quiz_button.disabled = true
	settings_button.disabled = true
	quit_button.disabled = true


func _enable_main_menu() -> void:
	quiz_button.disabled = false
	settings_button.disabled = false
	quit_button.disabled = false
