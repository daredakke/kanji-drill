extends Node


signal state_changed(state: Mode)
signal end_size_set(end_size: int)

enum Mode {
	MAIN_MENU,
	QUIZ,
	RESULTS
}

var _file: String = "res://assets/kanji.json"
var _kanji_array = JSON.parse_string(FileAccess.get_file_as_string(_file))

var questions_array: Array
var state: Mode
var start: int = 1
var end: int
var questions: int = 100
var current_question: int = -1
var score: int


func _ready() -> void:
	end = _kanji_array.size()

	end_size_set.emit(end)


func change_state(new_state: Mode) -> void:
	state = new_state

	state_changed.emit(state)


func valid_setup_values() -> bool:
	if start > end:
		return false

	return true


func generate_questions() -> void:
	questions_array = []
	current_question = -1
	score = 0

	while questions_array.size() < questions:
		var temp_array: Array

		temp_array = _kanji_array.slice(start, end)
		temp_array.shuffle()
		questions_array += temp_array

	if questions_array.size() > questions:
		questions_array = questions_array.slice(0, questions)


func get_next_question() -> Dictionary:
	current_question += 1

	if current_question == questions_array.size():
		return {}

	return questions_array[current_question]

