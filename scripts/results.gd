class_name Results
extends Control


@onready var answered_value: Label = %AnsweredValue
@onready var time_value: Label = %TimeValue
@onready var incorrect_list: ItemList = %IncorrectList
@onready var main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)


func focus_input() -> void:
	main_menu_button.grab_focus()


func update_score() -> void:
	var score = State.score
	var questions = State.questions
	
	answered_value.text = str(score) + "/" + str(questions)


func update_time_value(time_string: String) -> void:
	time_value.text = time_string


func _on_main_menu_button_pressed() -> void:
	State.change_state(State.Mode.MAIN_MENU)
