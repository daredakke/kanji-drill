class_name App
extends Control


@onready var main_menu: MainMenu = %MainMenu
@onready var settings: Settings = %Settings
@onready var quiz: Quiz = %Quiz


func _ready() -> void:
	main_menu.quiz_started.connect(_on_quiz_started)
	main_menu.settings_button_pressed.connect(settings.focus_menu)
	main_menu.quit_button_pressed.connect(_quit_game)
	
	settings.settings_closed.connect(_settings_closed)
	
	quiz.settings_button_pressed.connect(settings.focus_menu)


func _on_quiz_started() -> void:
	State.state = State.Mode.QUIZ
	
	main_menu.hide()
	quiz.show()


func _settings_closed() -> void:
	if State.state == State.Mode.MAIN_MENU:
		main_menu.focus_menu()
	elif State.state == State.Mode.QUIZ:
		quiz.focus_input()


func _quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
