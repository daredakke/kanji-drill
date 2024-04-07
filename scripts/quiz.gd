class_name Quiz
extends Control


signal settings_button_pressed

@onready var questions_value: Label = %QuestionsValue
@onready var time_value: Label = %TimeValue
@onready var settings_button: Button = %SettingsButton
@onready var reset_button: Button = %ResetButton
@onready var kanji_value: Label = %KanjiValue
@onready var answer_input: LineEdit = %AnswerInput
@onready var submit_button: Button = %SubmitButton


func _ready() -> void:
	hide()
	
	settings_button.pressed.connect(_show_settings)


func _show_settings() -> void:
	settings_button_pressed.emit()
	# Disable quiz controls
