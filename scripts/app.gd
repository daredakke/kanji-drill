class_name App
extends Control


@onready var main_menu: MainMenu = %MainMenu
@onready var settings: Settings = %Settings
@onready var quiz: Quiz = %Quiz
@onready var results: Control = %Results


func _ready() -> void:
	State.state_changed.connect(_handle_state_change)
	
	main_menu.quiz_started.connect(_on_quiz_started)
	main_menu.settings_button_pressed.connect(settings.focus_menu)
	main_menu.quit_button_pressed.connect(_quit_game)
	
	settings.settings_closed.connect(_settings_closed)
	
	quiz.settings_button_pressed.connect(settings.focus_menu)


func _on_quiz_started() -> void:
	State.change_state(State.Mode.QUIZ)


func _handle_state_change(state: State.Mode) -> void:
	if state == State.Mode.MAIN_MENU:
		main_menu.show()
		quiz.hide()
		main_menu.focus_menu()
	elif state == State.Mode.QUIZ:
		main_menu.hide()
		quiz.show()
		quiz.focus_input()


func _settings_closed() -> void:
	if State.state == State.Mode.MAIN_MENU:
		main_menu.focus_menu()
	elif State.state == State.Mode.QUIZ:
		quiz.focus_input()


func _quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
