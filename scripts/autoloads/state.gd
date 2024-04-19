extends Node


signal state_changed(state: Mode)

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
var end: int = 2200
var questions: int = 100
var current_question: int = -1


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
	
	while questions_array.size() < questions:
		var temp_array: Array
		
		temp_array = _kanji_array.slice(start, end + 1)
		temp_array.shuffle()
		questions_array += temp_array
	
	if questions_array.size() > questions:
		questions_array = questions_array.slice(0, questions + 1)


func get_next_question() -> Dictionary:
	current_question += 1
	
	if current_question == questions_array.size():
		change_state(Mode.RESULTS)
		return {}
	
	return questions_array[current_question]
	
