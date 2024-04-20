class_name Quiz
extends Control


signal settings_button_pressed
signal quiz_ended

var _question: Dictionary

var total_questions: int

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
@onready var submitted_label: Label = %SubmittedLabel
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
	
	answer_input.text_changed.connect(_submit_button_state)
	answer_input.text_submitted.connect(_on_answer_input_submitted)
	submit_button.pressed.connect(_on_submit_button_pressed)
	next_button.pressed.connect(next_question)


func focus_input() -> void:
	answer_input.text = ""
	answer_input.grab_focus()
	submit_button.disabled = true
	_enable_quiz()


func next_question() -> void:
	submitted_label.hide()
	answer.hide()
	focus_input()
	
	_question = State.get_next_question()
	
	if not _question.is_empty():
		kanji_value.text = _question.kanji
		kanji_label.text = _question.kanji
		keyword_label.text = _question.keyword
		
		var current_question := str(State.current_question + 1)
		questions_value.text = current_question + "/" + str(total_questions)


func _on_answer_input_submitted(new_text: String) -> void:
	_check_answer(new_text)


func _on_submit_button_pressed() -> void:
	_check_answer(answer_input.text)


func _check_answer(submitted_answer: String) -> void:
	var answer_text := _strip_keyword(submitted_answer.to_lower())
	var keyword := _strip_keyword(_question.keyword.to_lower())
	
	if answer_text == keyword:
		result_label.text = "CORRECT"
	elif _is_string_anagram(answer_text, keyword):
		submitted_label.show()
		submitted_label.text = "[" + submitted_answer + "]"
		result_label.text = "CORRECT*"
	elif _is_string_partial(answer_text, keyword):
		submitted_label.show()
		submitted_label.text = "[" + submitted_answer + "]"
		result_label.text = "PARTIAL"
	else:
		submitted_label.show()
		submitted_label.text = "[" + submitted_answer + "]"
		result_label.text = "INCORRECT"
	
	answer.show()
	next_button.grab_focus()
	_disable_quiz()


func _strip_keyword(keyword: String) -> String:
	var new_str := keyword
	
	new_str = new_str.replace("-", " ")
	new_str = new_str.replace(".", "")
	new_str = new_str.replace("(", "")
	new_str = new_str.replace(")", "")
	
	return new_str.strip_edges()


func _is_string_partial(str_one: String, str_two: String) -> bool:
	if str_one.length() < floori(str_two.length() * 0.5):
		return false
	
	var test_str := str_two.substr(0, str_one.length())
	
	if str_one == test_str:
		return true
	
	return false


func _is_string_anagram(str_one: String, str_two: String) -> bool:
	if str_one.length() != str_two.length():
		return false
	
	var string_one_array: Array = []
	var string_two_array: Array = []
	
	for c in str_one:
		string_one_array.push_back(c)
	
	for c in str_two:
		string_two_array.push_back(c)
	
	string_one_array.sort()
	string_two_array.sort()
	
	for i in range(string_one_array.size()):
		if string_one_array[i] != string_two_array[i]:
			return false
		
	return true


func _submit_button_state(new_text: String) -> void:
	if new_text != "":
		submit_button.disabled = false
	else:
		submit_button.disabled = true


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
