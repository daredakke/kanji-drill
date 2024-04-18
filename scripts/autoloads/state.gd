extends Node


signal state_changed(state: Mode)

enum Mode {
	MAIN_MENU,
	QUIZ,
	RESULTS
}

var _file: String = "res://kanji.json"
var _kanji_array = JSON.parse_string(FileAccess.get_file_as_string(_file))

var quiz_array: Array
var state: Mode = Mode.MAIN_MENU
var start: int = 1
var end: int = 2200
var questions: int = 100


func change_state(new_state: Mode) -> void:
	state = new_state
	
	state_changed.emit(state)


func valid_setup_values() -> bool:
	if start > end:
		return false
	
	return true


func generate_quiz() -> void:
	quiz_array = []
	
	while quiz_array.size() < questions:
		var temp_array: Array
		
		temp_array = _kanji_array.slice(start, end + 1)
		temp_array.shuffle()
		quiz_array += temp_array
	
	if quiz_array.size() > questions:
		quiz_array = quiz_array.slice(0, questions + 1)
		
