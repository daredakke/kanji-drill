class_name Quiz
extends Control


signal settings_button_pressed
signal quiz_ended

@onready var questions_value: Label = %QuestionsValue
@onready var time_value: Label = %TimeValue
@onready var settings_button: Button = %SettingsButton
@onready var main_menu_button: Button = %MainMenuButton
@onready var kanji_value: Label = %KanjiValue
@onready var answer_input: LineEdit = %AnswerInput
@onready var submit_button: Button = %SubmitButton
# Dialogue
@onready var dialogue: MarginContainer = %DialogueMargin
@onready var yes_button: Button = %YesButton
@onready var no_button: Button = %NoButton
# Answer
@onready var answer: MarginContainer = %AnswerMargin
@onready var kanji_label: Label = %KanjiLabel
@onready var keyword_label: Label = %KeywordLabel
@onready var result_label: Label = %ResultLabel
@onready var next_button: Button = %NextButton


func _ready() -> void:
	hide()
	dialogue.hide()
	answer.hide()
	
	settings_button.pressed.connect(_show_settings)
	main_menu_button.pressed.connect(_show_main_menu_dialogue)
	yes_button.pressed.connect(_return_to_main_menu)
	no_button.pressed.connect(_hide_main_menu_dialogue)
	
	submit_button.pressed.connect(_check_answer)
	next_button.pressed.connect(_next_question)


func focus_input() -> void:
	answer_input.grab_focus()
	_enable_quiz()


func _check_answer() -> void:
	answer.show()
	next_button.grab_focus()
	_disable_quiz()


func _next_question() -> void:
	answer.hide()
	focus_input()


func _show_settings() -> void:
	settings_button_pressed.emit()
	_disable_quiz()


func _show_main_menu_dialogue() -> void:
	dialogue.show()
	_disable_quiz()
	no_button.grab_focus()


func _hide_main_menu_dialogue() -> void:
	dialogue.hide()
	_enable_quiz()


func _return_to_main_menu() -> void:
	dialogue.hide()
	State.change_state(State.Mode.MAIN_MENU)


func _disable_quiz() -> void:
	settings_button.disabled = true
	main_menu_button.disabled = true
	answer_input.editable = false
	submit_button.disabled = true


func _enable_quiz() -> void:
	settings_button.disabled = false
	main_menu_button.disabled = false
	answer_input.editable = true
	submit_button.disabled = false
