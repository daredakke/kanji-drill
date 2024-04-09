extends Node


signal state_changed(state: Mode)

enum Mode {
	MAIN_MENU,
	QUIZ,
	RESULTS
}

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
